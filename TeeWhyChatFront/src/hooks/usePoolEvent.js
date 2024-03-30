import { ethers } from "ethers";
import { useEffect, useState } from "react";

const usePoolEvents = () => {
  const [event, setEvent] = useState("");
  const filter = {
    address: import.meta.env.VITE_staking_pool_address,
    topics: [
      [
        ethers.id("poolCreated(uint256,uint256,uint256,address)"),
        ethers.id("RewardClaim(uint256,address,uint256,uint256)"),
        ethers.id("Stake(uint256,address,uint256,uint256)"),
        ethers.id("Unstake(uint256,address,uint256,uint256)"),
      ],
    ],
  };
  const provider = new ethers.WebSocketProvider(
    import.meta.env.VITE_wss_rpc_url
  );

  useEffect(() => {
    (() => {
      provider.on(filter, (e) => {
        console.log("on", e);
        setEvent(e.transactionHash);
      });
    })();
    return () => provider.off(filter, (e) => console.log("off", e));
  }, []);

  return event;
};

export default usePoolEvents;
