import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { useWeb3ModalAccount } from "@web3modal/ethers/react";
import { getENSContract, getCHATContract } from "../constants/contracts";
import { getReadOnlyProvider } from "../constants/providers";

const useGetMessages = () => {
  const { address } = useWeb3ModalAccount();
  const { ensName } = useParams();
  const [sender, setSender] = useState("");
  const [messages, setMessages] = useState([]);

  useEffect(() => {
    const chat = getENSContract(getReadOnlyProvider);
    const ensContract = getCHATContract(getReadOnlyProvider);

    (async () => {
      const senderName = await ensContract.ensRecords(address);
      setSender(senderName[0]);

      const history = await chat.getMessages(sender, ensName);
      // wip

      console.log("History", history);
    })();
  }, [ensName]);

  return messages;
};

export default useGetMessages;
