/// DAY 14: Tests for Bounty Board
/// 
/// Today you will:
/// 1. Write comprehensive tests
/// 2. Test all the functions you've created
/// 3. Practice test organization
///
/// Note: You can copy code from day_13/sources/solution.move if needed

module challenge::day_14 {
    use std::vector;
    use std::string::String;
    use std::option::{Self, Option};
    use std::debug;

    const ERR_TASK_COUNT_MISMATCH: u64 = 0;
    const ERR_COMPLETED_COUNT_MISMATCH: u64 = 1;
    const ERR_TOTAL_REWARD_MISMATCH: u64 = 2;

    #[test_only]
    use std::unit_test::assert_eq;

    // Copy from day_13: All structs and functions
    public enum TaskStatus has copy, drop {
        Open,
        Completed,
    }

    public struct Task has copy, drop {
        title: String,
        reward: u64,
        status: TaskStatus,
    }

    public struct TaskBoard has drop {
        owner: address,
        tasks: vector<Task>,
    }

    public fun new_task(title: String, reward: u64): Task {
        Task {
            title,
            reward,
            status: TaskStatus::Open,
        }
    }

    public fun new_board(owner: address): TaskBoard {
        TaskBoard {
            owner,
            tasks: vector::empty(),
        }
    }

    public fun add_task(board: &mut TaskBoard, task: Task) {
        vector::push_back(&mut board.tasks, task);
    }

    public fun complete_task(task: &mut Task) {
        task.status = TaskStatus::Completed;
    }

    public fun total_reward(board: &TaskBoard): u64 {
        let len = vector::length(&board.tasks);
        let mut total = 0;
        let mut i = 0;
        while (i < len) {
            let task = vector::borrow(&board.tasks, i);
            total = total + task.reward;
            i = i + 1;
        };
        total
    }

    public fun completed_count(board: &TaskBoard): u64 {
        let len = vector::length(&board.tasks);
        let mut count = 0;
        let mut i = 0;
        while (i < len) {
            let task = vector::borrow(&board.tasks, i);
            if (task.status == TaskStatus::Completed) {
                count = count + 1;
            };
            i = i + 1;
        };
        count
    }

    #[test]
    fun test_create_board_and_add_task(){
        let mut board = new_board(@0x123);
        let task_title = b"Study Move".to_string();

        add_task(&mut board, new_task(task_title, 100));

        let count = vector::length(&board.tasks);
        assert!(count  == 1,  ERR_TASK_COUNT_MISMATCH);

        debug::print(&b"Test 1: Board creation and add task passed!".to_string());
    }

    #[test]
    fun test_complete_task(){
        let mut board = new_board(@0x123);
        add_task(&mut board, new_task(b"Task A".to_string(),100));
        add_task(&mut board, new_task(b"Task B".to_string(),200));

        let task_ref = vector::borrow_mut(&mut board.tasks, 0);
        complete_task(task_ref);

        let done_count = completed_count(&board);

        assert_eq!(done_count, 1);

        debug::print(&b"Task 2: Task completion passed!".to_string());
    }
    
    #[test]
    fun test_total_reward(){
        let mut board = new_board(@0x123);

        add_task(&mut board, new_task(b"Low".to_string(), 100));
        add_task(&mut board, new_task(b"Mid".to_string(), 200));
        add_task(&mut board, new_task(b"High".to_string(), 300));

        let total = total_reward(&board);

        assert!(total == 600, ERR_TOTAL_REWARD_MISMATCH);

        debug::print(&b"Test 3: Total reward calculation passed!".to_string());
    }

}

