<h1 align=center>
    Vulcan
</h1>

Development framework for Foundry projects, with a focus on developer experience and readability.

Built on top of [`forge-std`](https://github.com/foundry-rs/forge-std) <i style="color: red" class="fa fa-heart"></i>

Initially, Vulcan will provide functionality similar to what is already included in forge's VM and `forge-std`.

Over time, Vulcan will grow to include more functionality and utilities, eventually becoming a feature-rich development framework.

> **Warning**
> This library should be treated as highly experimental, its API WILL change, and there might be bugs in it. Don't use in production yet.

## Why Vulcan?

Our goal is to provide:
- Better naming for VM functionality (no more `prank`, `roll`, `warp`, ...)
- A testing framework with better readability and a familiar syntax
- Improved ergonomics
- ...

Vulcan test example:

```solidity
import { Test, expect, accounts, any, commands, Command,  watchers } from "vulcan/test.sol";

contract TestSomething is Test {
    using accounts for *;
    using watchers for *;

    function testSomething() external {
        // Create an address from a string, set the ETH balance and impersonate calls
        address alice = accounts.create("Alice").setBalance(123).impersonate();

        MyContract mc = new MyContract();

        // This will watch all contract calls and record their execution
        address(mc).watch().captureReverts();

        mc.doSomething();

        // Check that `doSomething()` reverted
        expect(address(mc).lastCall()).toHaveRevertedWith("Something went wrong");

        mc.doSomethingElse();

        // Check event emissions
        expect(address(mc).lastCall()).toHaveEmitted(
            "SomeEvent(address,bytes32,uint256)",
            [address(1).topic(), any()], // Event topics
            abi.encode(123) // Event data
        );

        // Expect style assertions!
        expect(true).toBeTrue();
        expect(true).toEqual(true);
        expect(123).toBeGreaterThanOrEqual(123);
        expect(123).not.toEqual(321);
        expect("Hello world!").toContain("Hello");

        // Nice external command API!
        Command memory ping = commands.create("ping").args(["-c", "1"]);
        res = ping.arg("etherscan.io").run();
        res = ping.arg("arbiscan.io").run();

        // And much more!
    }
}
```

## Planned Features

- [Huff language](https://huff.sh/) support out of the box
- Mocking framework
- Deployment management framework

## Contributing

At this stage we are looking for all kinds of feedback, as the general direction of the project is not fully defined yet. If you have any ideas to improve naming, ergonomics, or anything else, please open an issue or a PR.
