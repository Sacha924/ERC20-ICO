// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";

contract ERC20TD is ERC20, IExerciceSolution {

  mapping(address => bool) public teachers;
  event DenyTransfer(address recipient, uint256 amount);
  event DenyTransferFrom(address sender, address recipient, uint256 amount);

  address[] whitelist;
  mapping(address => bool) firstTier;
  mapping(address => bool) secondTier;

  constructor(string memory name, string memory symbol,uint256 initialSupply) public ERC20(name, symbol) {
        _mint(msg.sender, initialSupply/2);
        // the contract get half of the tokens
        teachers[msg.sender] = true;
        // whitelist.push(0x7C5629d850eCD1E640b1572bC0d4ac5210b38FA5);
        // secondTier[0x7C5629d850eCD1E640b1572bC0d4ac5210b38FA5] = true;
      }

  function distributeTokens(address tokenReceiver, uint256 amount) 
  public
  onlyTeachers
  {
    uint256 decimals = decimals();
    uint256 multiplicator = 10**decimals;
    _mint(tokenReceiver, amount * multiplicator);
  }

  function setTeacher(address teacherAddress, bool isTeacher) 
  public
  onlyTeachers
  {
    teachers[teacherAddress] = isTeacher;
  }

  modifier onlyTeachers() {
    require(teachers[msg.sender]);
    _;
  }

function transfer(address recipient, uint256 amount) public override(ERC20,IERC20) returns (bool) {
	emit DenyTransfer(recipient, amount);
        return false;
    }

  function transferFrom(address sender, address recipient, uint256 amount) public override(ERC20,IERC20) returns (bool) {
  emit DenyTransferFrom(sender, recipient, amount);
        return false;
    }


  function symbol() public view override(ERC20,IExerciceSolution) returns (string memory){
    return 'z';
  }
    
  function getToken() external override(IExerciceSolution) returns (bool){
    if(this.isCustomerWhiteListed(msg.sender))
      {
        _mint(msg.sender,2);
        return true;
      }
    return false;
  }

  function buyToken() external payable override returns (bool){
    if(msg.value>0)
    {
      if(this.isCustomerWhiteListed(msg.sender))
      {
        if(this.customerTierLevel(msg.sender)==1)
        {
          _mint(msg.sender,msg.value);
          return true;
        }
        if(this.customerTierLevel(msg.sender)==2)
        {
          _mint(msg.sender,2*msg.value);
          return true;
        }
      }
    }
    return false;
  }

  function isCustomerWhiteListed(address customerAddress) external override returns (bool){
    for (uint i = 0; i < whitelist.length; i++){
      if(whitelist[i] == customerAddress){
        return true;
      } 
    }
    return false;
  }

  function removeFromWhitelist(address _address) public  {
    address[] memory temp = whitelist;
    whitelist = new address[](0); // Reset the whitelist

    for (uint i = 0; i < temp.length; i++){
      if(temp[i] != _address){
        whitelist.push(temp[i]);
        } 
      }
    }

  function addInWhitelist(address _address) public{
    whitelist.push(_address);
  }

  function customerTierLevel(address customerAddress) external override returns (uint256){
    if(secondTier[customerAddress]){
      return 2;
    } 
    else if(firstTier[customerAddress]){
      return 1;
    }
    return 0;
  }

  function updateTier(address _address, uint256 _tier, bool _val) public{
        if (_tier == 1) {
            firstTier[_address] = _val;
        }else if (_tier == 2) {
            secondTier[_address] = _val;
        }
        
    }
}