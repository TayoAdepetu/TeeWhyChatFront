import { ethers } from "ethers";

import TokenAbi from "../constants/erc20Abi.json";
import StakingPoolAbi from "../constants/stakingPoolAbi.json";

export const getTokenInterface = () => new ethers.Interface(TokenAbi);

export const getStakingPoolInterface = () =>
  new ethers.Interface(StakingPoolAbi);

export const encodeStakingPoolCall = (fn, values) => {
  const itf = getStakingPoolInterface();
  const data = itf.encodeFunctionData(fn, values);

  return data;
};

export const decodeStakingPoolResult = (fn, data) => {
  const itf = getStakingPoolInterface();
  const result = itf.decodeFunctionResult(fn, data);

  return result;
};
