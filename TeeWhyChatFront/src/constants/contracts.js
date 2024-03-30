import { ethers } from "ethers";
import ensABI from "./ensAbi.json";
import chatABI from "./chatAbi.json";
import MultiCallAbi from "./multicall.json";

const ensAddress = import.meta.env.VITE_ENS_contract;
const chatAddress = import.meta.env.VITE_CHAT_contract;

export const getENSContract = (providerOrSigner) => {
  return new ethers.Contract(ensAddress, ensABI, providerOrSigner);
};

export const getCHATContract = (providerOrSigner) => {
  return new ethers.Contract(chatAddress, chatABI, providerOrSigner);
};

export const getMultiCallContract = (provider) => {
  return new ethers.Contract(
    import.meta.env.VITE_multicall_address,
    MultiCallAbi,
    provider
  );
};
