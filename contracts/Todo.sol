// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
    
contract Todo {

    struct Task {
        string task;
        uint deadline;
        bool isCompleted;
    }

    mapping(address => Task[]) todoTask;

    event SetTask(address indexed user, string indexed task, uint indexed deadline);
    event UpdateTask(address indexed user, string indexed task, uint indexed taskIndex);
    event DeleteTask(address indexed user, uint indexed _taskIndex);

    function setTask(string calldata _task, uint _deadline) external {
        address user = msg.sender;
        require(user != address(0), "cannot set task to the zero address");

        todoTask[user].push(Task(_task, _deadline + block.timestamp, false));

        emit SetTask(user, _task, _deadline);
    }

    function getTask() external view returns(Task[] memory) {
        Task[] storage todos = todoTask[msg.sender];
        return todos;
    }

    function updateTask(uint _taskIndex, string calldata _task) external {
        Task storage todo = todoTask[msg.sender][_taskIndex];
        todo.task = _task;
        
        emit UpdateTask(msg.sender, _task, _taskIndex);
    }

    function completeTask(uint _taskIndex) external {
        Task storage todo = todoTask[msg.sender][_taskIndex];
        todo.isCompleted = true;
    }


    function deleteTask(uint _taskIndex) external {
        delete todoTask[msg.sender][_taskIndex];

        emit DeleteTask(msg.sender, _taskIndex);
    }
}