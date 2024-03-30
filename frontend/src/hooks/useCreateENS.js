import { useCallback } from "react";
import { useWeb3ModalProvider } from "@web3modal/ethers/react";

import { getENSContract } from "../constants/contracts";
import { getReadWriteProvider } from "../constants/providers";

const useCreateENS = () => {
  const { walletProvider } = useWeb3ModalProvider();

  return useCallback(async (ensName, ensUri) => {
    const provider = getReadWriteProvider(walletProvider);
    const signer = await provider.getSigner();
    const ensContract = getENSContract(signer);

    try {
      const tx = await ensContract.setENSRecord(ensName, ensUri);
      const receipt = await tx.wait();
      console.log(receipt);
    } catch (error) {
      const revertData = error.data;
      const revertName = ensContract.interface.parseError(revertData)?.name;

      switch (revertName) {
        case "EnsRecordExists":
          throw new Error("ENS NAME Exists");
        default:
          console.error(error);
          throw new Error("Error creating ens record");
      }
    }
  }, []);
};

export default useCreateENS;
