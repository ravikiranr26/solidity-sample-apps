pragma solidity >=0.4.16 <0.9.0;

pragma experimental ABIEncoderV2;

contract MultiSigWallet {
    uint minApprovers;

    address beneficiary;
    address owner;

    mapping (address => bool) approvedBy;
    mapping (address => bool) isApprover;
    uint approvalsNum;

    constructor(
        address[] _approvers,
        uint _minApprovers,
        address _beneficary
    ) public payable {
        
        require(_minApprovers <= _approvers.length, "Required number of approvers should be less than number of approvers");

        minApprovers = _minApprovers;
        beneficary = _beneficary;
        owner = msg.sender;

        for (uint index = 0; index < _approvers.length; index++) {
            address approver = _approvers[index];
            isApprover[approver] = true;
        }
    }

    function approve() public {
        require(isApprover[msg.sender], "Not an approver");
        if (!approvedBy[msg.sender]) {
            approvalsNum++;
            approvedBy[msg.sender] = true;
        }

        if(approvalsNum == minApprovers) {
            beneficiary.send(address(this).balance);
            selfdestruct(owner);
        }
    }

    function reject() public {
        require(isApprover[msg.sender], "Not an approver");

        selfdestruct(owner);
    }
}