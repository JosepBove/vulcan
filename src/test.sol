// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {console} from "./Console.sol";
import {vulcan, Log} from "./Vulcan.sol";
import {any} from "./Any.sol";
import {accounts} from "./Accounts.sol";
import {commands, Command} from "./Command.sol";
import {ctx} from "./Context.sol";
import {env} from "./Env.sol";
import {events} from "./Events.sol";
import {expect} from "./Expect.sol";
import {forks, Fork} from "./Fork.sol";
import {fs, FsMetadata} from "./Fs.sol";
import {huff, Huffc} from "./Huff.sol";
import {json, JsonObject} from "./Json.sol";
import {strings} from "./Strings.sol";
import {watchers, Watcher} from "./Watcher.sol";
import {config, Rpc} from "./Config.sol";
import {fmt} from "./Fmt.sol";
import {format} from "./format.sol";
import {println} from "./println.sol";

// @dev Main entry point to Vulcan tests
contract Test {
    bool public IS_TEST = true;

    constructor() {
        vulcan.init();
    }

    function failed() public view returns (bool) {
        return vulcan.failed();
    }

    modifier shouldFail() {
        bool pre = vulcan.failed();
        _;
        bool post = vulcan.failed();

        if (pre) {
            return;
        }

        if (!post) {
            revert("Didn't fail");
        }

        vulcan.clearFailure();
    }
}
