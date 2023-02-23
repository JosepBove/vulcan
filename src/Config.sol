// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Vm as Hevm} from "forge-std/Vm.sol";
import {vulcan, Rpc} from "./Vulcan.sol";

type Config is bytes32;

library config {
    /// @dev Obtains a specific RPC from the configuration by name.
    /// @param name The name of the RPC to query.
    /// @return The url of the RPC.
    function rpcUrl(string memory name) internal view returns (string memory) {
        return vulcan.hevm.rpcUrl(name);
    }

    /// @dev Obtains all the RPCs from the configuration.
    /// @return All the RPCs as `[name, url][]`.
    function rpcUrls() internal view returns (string[2][] memory) {
        return vulcan.hevm.rpcUrls();
    }

    /// @dev Obtains all the RPCs from the configuration.
    /// @return rpcs All the RPCs as `Rpc[]`.
    function rpcUrlStructs() internal view returns (Rpc[] memory rpcs) {
        Hevm.Rpc[] memory _rpcs = vulcan.hevm.rpcUrlStructs();
        assembly {
            rpcs := _rpcs
        }
    }
}
