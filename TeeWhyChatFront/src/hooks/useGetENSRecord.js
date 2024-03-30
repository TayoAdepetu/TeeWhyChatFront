import { useState, useCallback } from "react";
import { getReadOnlyProvider } from "../constants/providers";
import { getENSContract } from "../constants/contracts";

const useGetENSRecord = (address) => {
  const [ensName, setEnsName] = useState("");
  const [ensNameOwner, setEnsNameOwner] = useState("");
  const [ensUri, setEnsUri] = useState("");

  useCallback(() => {
    // fetch domain details
    const getEnsRecord = async () => {
      if (!address) return;

      const ensContract = getENSContract(getReadOnlyProvider);
      const [owner, name, uri] = await ensContract.ensRecords(address);

      setEnsName(name);
      setEnsNameOwner(owner);
      setEnsUri(avatarHash);
    };

    getEnsRecord();
  }, [address])();
  return { ensName, ensNameOwner, ensUri };
};

export default useGetENSRecord;
