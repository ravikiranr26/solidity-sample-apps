pragma solidity >=0.4.16 <0.9.0;

pragma experimental ABIEncoderV2;

/// @title A Voting contract for casting there vote
/// @author rknmit
/// @notice You can vote based on the options Ex: "Coffee" / "Tea"
/// @dev Compile the program

contract Voter {
    struct OptionsPos {
        uint pos;
        bool exists;
    }

    uint[] public votes;
    string[] public options;
    mapping (address => bool) hasVoted;
    mapping (string => OptionsPos) posOfOption;

    constructor(string[] _options) public {
        options = _options;
        votes.length = options.length;

        for (uint index = 0; index < option.length; index++) {
            OptionsPos memory optionsPos = OptionsPos(index, true);
            string optionName = options[index];
            posOfOption[optionName] = OptionsPos;
        }
    }

    function vote(uint option) public {
        require(0 <= option && option < options.length, "Invalid option");
        require(!hasVoted[msg.sender], "Account has already voted");

        votes[option] = votes[option] + 1;
        hasVoted[msg.sender] = true;
    }

    function vote(string optionName) public {
        require(!hasVoted[msg.sender], "Account has already voted");

        OptionsPos memory optionPos = posOfOption[optionName];
        require(optionPos.exists, "Option does not exist");

        votes[optionPos.pos] = votes[optionPos.pos] + 1;
        hasVoted[msg.sender] = true;
    }

    function getOptions() public view returns (string[]) {
        return options;
    }

    function getVotes() public view returns (uint[]) {
        return votes;
    }
}