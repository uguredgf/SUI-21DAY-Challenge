/// DAY 8: New Module & Simple Task Struct
/// 
/// Today you will:
/// 1. Start a new project: Task Bounty Board
/// 2. Create a Task struct
/// 3. Write a constructor function

module challenge::day_08 {
    use std::string::String;

    // TODO: Define a struct called 'Task' with:
    public struct Task has copy, drop{
        title: String,
        reward: u64,
        done: bool,
    }

    public fun new_task(title: String, reward: u64): Task{
        Task{
            title,
            reward,
            done: false,
        }
    }


#[test]

    fun test_create_task(){
        let title = b"Kod yaz, odulu kap".to_string();
        let reward = 1000;
        let task = new_task(title,reward);

        assert!(task.reward==1000,0);
        assert!(task.done==false,1);
    }
     }


