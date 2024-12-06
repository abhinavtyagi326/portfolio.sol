// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RNNManager {
    // Struct for storing encrypted data and related details
    struct EncryptedData {
        string userId;
        string encryptedData;
        bool isTrained; // Whether the data has been used for training
    }

    // Struct for storing prediction results
    struct Prediction {
        string userId;
        string result;
        uint256 timestamp;
    }

    // Mapping to store encrypted data per user
    mapping(string => EncryptedData) private dataStorage;

    // Mapping to store prediction results per user
    mapping(string => Prediction[]) private predictions;

    // Events
    event DataBroadcasted(string userId, string message);
    event PredictionCompleted(string userId, string result);
    event TrainingCompleted(string userId);

    // Modifier to ensure only the authorized RNN can call certain functions
    address public rnnNode;
    modifier onlyRNNNode() {
        require(msg.sender == rnnNode, "Only authorized RNN node can perform this action");
        _;
    }

    constructor(address _rnnNode) {
        rnnNode = _rnnNode;
    }

    // Function to broadcast encrypted data to the RNN node
    function broadcastData(string memory userId, string memory encryptedData) public {
        dataStorage[userId] = EncryptedData(userId, encryptedData, false);
        emit DataBroadcasted(userId, "Data broadcasted for training/prediction");
    }

    // Function to store prediction results (called by the RNN node)
    function submitPrediction(string memory userId, string memory result) public onlyRNNNode {
        predictions[userId].push(Prediction(userId, result, block.timestamp));
        emit PredictionCompleted(userId, result);
    }

    // Function to mark data as trained (called by the RNN node)
    function markAsTrained(string memory userId) public onlyRNNNode {
        require(!dataStorage[userId].isTrained, "Data already trained");
        dataStorage[userId].isTrained = true;
        emit TrainingCompleted(userId);
    }

    // Function to retrieve prediction results for a user
    function getPredictions(string memory userId) public view returns (Prediction[] memory) {
        return predictions[userId];
    }

    // Function to retrieve encrypted data (if needed for debugging or auditing)
    function getEncryptedData(string memory userId) public view returns (EncryptedData memory) {
        return dataStorage[userId];
    }
}
