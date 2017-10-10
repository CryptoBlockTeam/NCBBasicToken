/**
 * ERC-20 Mintable Token Smart Contract implementation.
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
import './OBLToken.sol';
import '../zeppelin-solidity/contracts/token/MintableToken.sol';
import '../zeppelin-solidity/contracts/math/SafeMath.sol';

contract OBLMintableToken is OBLToken, MintableToken {
  using SafeMath for uint256;

	string public name = "OrangeBlockLab Mintable Token";
	string public symbol = "OBL";
	uint256 public decimals = 8;

	string public version = '0.0.1';

	/**
	 * @dev Cap for minted tokens.
	 */
	uint256 public capAmount;

	/**
	 * @dev Contructor that gives msg.sender all of existing tokens. 
	 */
	function OBLMintableToken(uint256 initialSupply, uint256 cap) {
		totalSupply = initialSupply;
		capAmount = cap;
		balances[msg.sender] = initialSupply;
	}

	/**
   	 * @dev Function to mint tokens only if cap not reached.
   	 * @param _to The address that will receive the minted tokens.
     * @param _amount The amount of tokens to mint.
     * @return A boolean that indicates if the operation was successful.
     */
	function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool){
		uint256 newTotalSupply = totalSupply.add(_amount);
		require(newTotalSupply <= capAmount);
		return super.mint(_to, _amount);
	}
	/**
   	 * @dev Function to increase tokens cap limit
     * @param _amount The amount of tokens to increase cap
     * @return A boolean that indicates if the operation was successful.
     */
	function increaseCapAmount(uint256 _amount) onlyOwner returns (bool) {
        capAmount = capAmount.add(_amount);
        return true;
    }

	/**
   	 * @dev Function to decrease tokens cap limit
     * @param _amount The amount of tokens to decrease cap
     * @return A boolean that indicates if the operation was successful.
     */
    function decreaseCapAmount(uint256 _amount) onlyOwner returns (bool) {
        capAmount = capAmount.sub(_amount);
        return true;
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

	    OBLMintableToken token = OBLMintableToken(_token);
	    uint balance = token.balanceOf(this);
	    token.transfer(owner, balance);

	    ClaimTransfer(owner, balance);
	}

}
