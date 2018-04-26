/**
 * ERC-20 Basic Token Smart Contract implementation.
 *
 * Copyright © 2018 by NewCryptoBlock.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).
 */

pragma solidity ^0.4.11;

import './Protection.sol';
import './TokenRecipient.sol';
import './NCBToken.sol';

contract NCBBasicToken is NCBToken {
	string public name = "NewCryptoBlock Basic Token";
	string public symbol = "NCB";
	uint256 public decimals = 8;

	string public version = '0.0.1';

	/**
	 * @dev Contructor that gives msg.sender all of existing tokens.
	 */
	function NCBBasicToken(uint256 initialSupply) {
		totalSupply = initialSupply;
		balances[msg.sender] = initialSupply;
	}

  	/**
	 * @dev Peterson's Law Protection
	 * Claim tokens
	 */
	function claimTokens(address _token) onlyOwner {
	    if (_token == 0x0) {
	        owner.transfer(this.balance);
	        return;
	    }

		NCBBasicToken token = NCBBasicToken(_token);
	    uint balance = token.balanceOf(this);
	    token.transfer(owner, balance);

	    ClaimTransfer(owner, balance);
	}

}
