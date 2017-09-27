/**
 * ERC-20 Standard Token Smart Contract implementation.
 * 
 * Copyright © 2017 by OrangeBlockLab.
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
import '../zeppelin-solidity/contracts/token/PausableToken.sol';
import '../zeppelin-solidity/contracts/ownership/Ownable.sol';

contract OBLBasicToken is Protection, Ownable, PausableToken {
	string public name = "OrangeBlockLab Token";
	string public symbol = "OBL";
	uint256 public decimals = 8;

	string public version = '0.0.1';

	/**
	 * @dev Logged when claimed tokens were transferred to the owner.
	 *
	 * @param _to address of the owner, tokens were transferred to
	 * @param _value number of tokens transferred
	 */
	event ClaimTransfer (address indexed _to, uint256 _value);

	/**
	 * @dev Contructor that gives msg.sender all of existing tokens. 
	 */
	function OBLBasicToken(uint256 initialSupply) onlyOwner {
		totalSupply = initialSupply;
		balances[msg.sender] = initialSupply;
	}

	/**
     * @dev Transfer with short address attack protection
     */
	function transfer(address _to, uint _value) onlyPayloadSize(2) returns (bool) {
    	return super.transfer(_to, _value);
  	}

	/**
     * @dev TransferFrom with short address attack protection
     */
	function transferFrom(address _from, address _to, uint _value) onlyPayloadSize(3) returns (bool) {
		return super.transferFrom(_from, _to, _value);
	}

	/**
     * @dev Allowance with short address attack protection
     */
	function allowance(address _owner, address _spender) onlyPayloadSize(2) constant returns (uint256 remaining) {
    	return super.allowance(_owner, _spender);
  	}

	/**
     * @dev Approve and then communicate the approved contract in a single transaction
     */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        TokenRecipient spender = TokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
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

	    OBLBasicToken token = OBLBasicToken(_token);
	    uint balance = token.balanceOf(this);
	    token.transfer(owner, balance);

	    ClaimTransfer(owner, balance);
	}

}
