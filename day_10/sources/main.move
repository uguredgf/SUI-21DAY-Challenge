/// DAY 10: Visibility Modifiers (Public vs Private Functions)
/// 
/// Today you will:
/// 1. Learn about visibility modifiers (public vs private)
/// 2. Design a public API
/// 3. Write a function to complete tasks
///
/// Note: You can copy code from day_09/sources/solution.move if needed

module challenge::day_10 {
    use std::string::String;

    // Copy from day_09: TaskStatus enum and Task struct
    public enum TaskStatus has copy, drop {
        Open,
        Completed,
    }

    public struct Task has copy, drop {
        title: String,
        reward: u64,
        status: TaskStatus,
    }

    public fun new_task(title: String, reward: u64): Task {
        Task {
            title,
            reward,
            status: TaskStatus::Open,
        }
    }

    public fun is_open(task: &Task): bool {
        task.status == TaskStatus::Open
    }

    // TODO: Write a public function 'complete_task' that:

    public fun complete_task(task: &mut Task) {
        task.status = TaskStatus::Completed;

    }

    // TODO: (Optional) Write a private helper function

    fun is_reward_valid(reward: u64): bool{
        reward>0
    }

    public fun create_valid_tsak(title: String, reward: u64): Task{
        assert!(is_reward_valid(reward),0);
        new_task(title,reward)
    }

    #[test]
    fun test_complete_task(){
        let mut task = new_task(b"Test calisiyor mu?".to_string(),100);

        assert!(is_open(&task),0);

        complete_task(&mut task);

        assert!(!is_open(&task),1);
    }
}

