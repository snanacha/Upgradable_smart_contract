pragma solidity ^0.4.24;

//import "https://github.com/zeppelinos/zos-lib/blob/v1.0.0/contracts/migrations/Migratable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-sdk/blob/master/packages/lib/contracts/Initializable.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20Burnable.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts-ethereum-package/blob/master/contracts/token/ERC20/ERC20Burnable.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract UpgradeableERC20 is Initializable {

    string public Name;
    string public Symbol;
    uint8 public Decimals;
    address Owner;
    uint256 public TotalSupplyValue;
    mapping(address => uint256) private _balances;
    constructor()public { 
        Owner = msg.sender;
    }
    function initialize(address _sender, string _name, string _symbol, uint8 _decimals)
    public initializer() 
    {
        require(_sender != address(0), "Null address not allowed.");
        require(Owner==_sender,"You are not the owner!");
        require(bytes(_name).length > 0, "Name should be provided.");
        require(bytes(_symbol).length > 0, "Symbol should be provided.");
        require(_decimals >= 0, "Decimals should be a non-negative integer quantity.");

        // token parameters initialization
        Name = _name;
        Symbol = _symbol;
        Decimals = _decimals;

        // calculating total supply value
        TotalSupplyValue = 1000000000 * (10 ** uint256 (Decimals));
        
        // setting token's total supply
        uint256 totalSupply_ = TotalSupplyValue;

        // updating the token balance of the owner
        // _balances[_sender] = _balances[_sender].add(_totalSupplyValue);
        _balances[_sender] += totalSupply_;
    }

    function() public payable {
        revert("This contract does not support receiving ether.");
    }
}