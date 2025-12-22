/// DAY 4: Vector + Ownership Basics
/// 
/// Today you will:
/// 1. Learn about vectors
/// 2. Create a list of habits
/// 3. Understand basic ownership concepts

module challenge::day_04 {
    use std::vector;

    // Copy the Habit struct from day_03
    public struct Habit has copy, drop {
        name: vector<u8>,
        completed: bool,
    }

    public fun new_habit(name: vector<u8>): Habit {
        Habit {
            name,
            completed: false,
        }
    }

    // TODO: Create a struct called 'HabitList' with:
    public struct HabitList has drop{
        habits: vector<Habit>
    }


    // TODO: Write a function 'empty_list' that returns an empty HabitList
        public fun empty_list(): HabitList{
            HabitList{
                habits: vector::empty<Habit>()
            }
        }


    // TODO: Write a function 'add_habit' that takes:
    public fun add_habit(list: &mut HabitList,habit: Habit){
        vector::push_back(&mut list.habits, habit);
    }
}

