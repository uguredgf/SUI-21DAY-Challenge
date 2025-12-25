/// DAY 7: Unit Tests for Habit Tracker
///
/// Today you will:
/// 1. Learn how to write tests in Move
/// 2. Write tests for your habit tracker
/// 3. Use assert! macro
///
/// Note: You can copy code from day_06/sources/solution.move if needed

module challenge::day_07 {
    use std::vector;
    use std::string::{Self, String};

    // Copy from day_06: Habit struct with String
    public struct Habit has copy, drop {
        name: String,
        completed: bool,
    }

    public struct HabitList has drop {
        habits: vector<Habit>,
    }

    public fun new_habit(name: String): Habit {
        Habit {
            name,
            completed: false,
        }
    }

    public fun make_habit(name_bytes: vector<u8>): Habit {
        let name = string::utf8(name_bytes);
        new_habit(name)
    }

    public fun empty_list(): HabitList {
        HabitList {
            habits: vector::empty(),
        }
    }

    public fun add_habit(list: &mut HabitList, habit: Habit) {
        vector::push_back(&mut list.habits, habit);
    }

    public fun complete_habit(list: &mut HabitList, index: u64) {
        let len = vector::length(&list.habits);
        if (index < len) {
            let habit = vector::borrow_mut(&mut list.habits, index);
            habit.completed = true;
        }
    }

    // Note: assert! is a built-in macro in Move 2024 - no import needed!

    // TODO: Write a test 'test_add_habits' that:

    #[test]
    fun test_add_habits() {
        let mut list = empty_list();

        add_habit(&mut list, new_habit(b"Egzersiz".to_string()));
        add_habit(&mut list, new_habit(b"Kitao oku".to_string()));

        assert!(vector::length(&list.habits)==2,0);
    }

    // TODO: Write a test 'test_complete_habit' that:

    #[test]
    fun test_complete_habit() {
        let mut list = empty_list();
        add_habit(&mut list, new_habit(b"Su Ic".to_string()));

        complete_habit(&mut list, 0);

        let habit = vector::borrow(&list.habits, 0);

        assert!(habit.completed==true,1);
    }
}

