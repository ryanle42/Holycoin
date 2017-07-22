pragma solidity ^0.4.11;

contract ERC20Token {
  function balanceOf(address _owner) constant returns (uint256 balance);
  function transfer(address _to, uint256 _value) returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
  function approve(address _spender, uint256 _value) returns (bool success);
  function allowance(address _owner, address _spender) constant returns (uint256 remaining);
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract owned {
	address public owner;

	function owned() {
		owner = msg.sender;
	}

	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}

	function transferOwnership(address newOwner) onlyOwner {
		owner = newOwner;
	}
}

contract mortal is owned{
	function kill() onlyOwner {
		selfdestruct(owner);
	}
}

contract HolyCoin is ERC20Token, owned, mortal {

  uint256 price;
  address[] trustees;
  mapping(address => uint256) balances;
	mapping(address => mapping(address => uint256)) allowances;

  function HolyCoin() {
    uint256 initialSupply = 1000000000;
    price = 1;
    balances[this] = initialSupply;
  }

	function balanceOf(address _owner) constant returns (uint256 balance) {
		return balances[_owner]; 
	}

  function transfer(address _to, uint256 _value) returns (bool success) {
  	require(balances[msg.sender] >= _value);
  	require(balances[msg.sender] > balances[msg.sender] - _value);
  	require(balances[_to] < balances[_to] + _value);
  	balances[msg.sender] -= _value;
  	balances[_to] += _value;
  	Transfer(msg.sender, _to, _value);
  	return true;
  }
  
  function transferFrom(address _from, address _to, uint256 _value) 
  returns (bool success)
  {
  	require(allowances[_from][msg.sender] >= _value);
  	require(allowances[_from][msg.sender] > allowances[_from][msg.sender] - _value);
  	require(balances[_to] < balances[_to] + _value);
  	allowances[_from][msg.sender] -= _value;
  	balances[_to] += _value;
  	Transfer(_from, _to, _value);
  	return true;	
  }  

  function approve(address _spender, uint256 _value) returns (bool success) {
  	allowances[msg.sender][_spender] = _value;
  	Approval(msg.sender, _spender, _value);
  	return true;
  }

  function allowance(address _owner, address _spender) 
  constant 
  returns (uint256 remaining)
  {
  	return allowances[_owner][_spender];
  }

  function buy() payable {
   uint256 _amount = msg.value / price;
   require(balances[this] >= _amount);
   balances[this] -= _amount;
   balances[msg.sender] += _amount;
  }
}