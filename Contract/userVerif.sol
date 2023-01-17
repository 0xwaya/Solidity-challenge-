
pragma solidity ^0.5.0;

contract userVerif {
    // Mapping of user addresses to their identity information
    mapping (address => User) public users;
    
    // Struct to store user identity information
    struct User {
        string name;
        string email;
        string phone;
        string address;
        string idNumber;
        string idType;
        bool verified;
    }
    
    // Event to be triggered when a user is verified
    event UserVerified(address indexed user);
    
    // Function to register a user's identity information
    function registerUser(string memory _name, string memory _email, string memory _phone, string memory _address, string memory _idNumber, string memory _idType) public {
        // Create a new user
        User memory newUser = User(_name, _email, _phone, _address, _idNumber, _idType, false);
        
        // Store the new user in the mapping
        users[msg.sender] = newUser;
    }
    
    // Function to verify a user's identity
    function verifyUser(address _user) public {
        // Retrieve the user from the mapping
        User storage user = users[_user];
        
        // Verify the user's identity
        user.verified = true;
        
        // Trigger the UserVerified event
        emit UserVerified(_user);
    }
    
    // Function to check if a user is verified
    function isVerified(address _user) public view returns (bool) {
        // Retrieve the user from the mapping
        User storage user = users[_user];
        
        // Return the user's verified status
        return user.verified;
    }
}
