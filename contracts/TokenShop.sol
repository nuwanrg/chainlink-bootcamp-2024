// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {Token} from "contracts/Token.sol";


contract TokenShop{
    AggregatorV3Interface internal dataFeed;
    address owner;
    Token internal token;
    uint public rate =100;


    constructor (address _tokenAddress){
        //token = new Token(tokenAddress);
         dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        //_tokenAddress 0xd1cD888FDed5c0Cb7003564D18fB3AF6790EB92f
        token = Token(_tokenAddress);
        owner = msg.sender;
    }

    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    // Receive function to handle incoming ETH and mint tokens
    receive() external payable {
        // uint256 tokenAmount = msg.value * rate;
        token.mint(msg.sender, msg.value);
    }

    // Function to set a new rate
    function setRate(uint256 newRate) public {
        require(msg.sender == owner, "Only the owner can set the rate.");
        rate = newRate;
    }

    // Allow owner to withdraw ETH from the contract
    function withdrawETH() public {
        require(msg.sender == owner, "Only the owner can withdraw.");
        payable(owner).transfer(address(this).balance);
    }


}