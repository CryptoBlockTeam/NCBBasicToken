/**
 * Short address attack protection Smart Contract implementation.
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

contract Protection {

	/**
	 * @dev Protection against short address attack
	 */
	modifier onlyPayloadSize(uint numwords) {
	    assert(msg.data.length == numwords * 32 + 4);
	    _;
	}
}
