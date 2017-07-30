pragma solidity ^0.4.11;

contract ERC20Token {
  uint256 public totalSupply;
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
  uint256 buyPrice;
  uint256 spotsInHeaven;
  uint256 totalSupply;

  mapping(address => uint256) balances;
  mapping(address => uint256) indulgences;
  mapping(address => bytes32) confessions;
  mapping(address => string) names;
  mapping(address => mapping(address => uint256)) private allowances;

  event Indulgence(address indexed _from, uint256 _value);
  event Confession(address indexed _from, bytes32 _confession);

  function () payable {
    uint256 _amount;
    _amount = msg.value / buyPrice;
    require(balances[msg.sender] < balances[msg.sender] + _amount);
    totalSupply += _amount;
    balances[msg.sender] += _amount;
    Transfer(this, msg.sender, _amount);
  }

  function HolyCoin() {
    buyPrice = 1;
  }

  function balanceOf(address _owner) constant returns (uint256 _balance) {
    return (balances[_owner]);
  }

  function transfer(address _to, uint256 _value) returns (bool _success) {
    require(balances[msg.sender] >= _value);
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
    require(balances[_from] >= _value);
    require(balances[_to] < balances[_to] + _value);
    allowances[_from][msg.sender] -= _value;
    balances[_from] -= _value;
    balances[_to] += _value;
    Transfer(_from, _to, _value);
    return true;
  }
  
  function approve(address _spender, uint256 _value) returns (bool _success) {
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

  // burns holycoin for indulgence
  function giveIndulgence(uint256 _amount) returns (bool _success) {
    require(balances[msg.sender] >= _amount);
    balances[msg.sender] -= _amount;
    indulgences[msg.sender] += _amount;
    Indulgence(msg.sender, _amount);
    return true;
  }

  function confess(bytes32 _confession) {
    Confession(msg.sender, _confession);
  }
}

