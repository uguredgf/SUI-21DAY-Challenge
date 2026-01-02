/// DAY 15: Read Object Model & Create FarmState Struct (no UID yet)
/// 
/// Today you will:
/// 1. Learn about Sui objects (conceptually)
/// 2. Create a simple struct for farm counters
/// 3. Write basic functions to increment counters
/// 
/// NOTE: Today we're NOT creating a Sui object yet, just a regular struct.
/// We'll add UID and make it an object tomorrow.

module challenge::day_15 {
    use std::vector;
    
    const MAX_PLOTS: u64 = 20;
    const E_PLOT_NOT_FOUND: u64 = 4;
    const E_PLOT_LIMIT_EXCEEDED: u64 = 1;
    const E_INVALID_PLOT_ID: u64 = 2;
    const E_PLOT_ALREADY_EXISTS: u64 = 3;

    public struct FarmCounters has copy, drop, store {
    planted: u64,
    harvested: u64,
    plots: vector<u8>,
    }

    fun new_counters(): FarmCounters {
    FarmCounters{
        planted: 0,
        harvested: 0,
        plots: vector::empty<u8>()
      }
    }

    public fun plant(counters: &mut FarmCounters, plot_id: u8) {
    
    assert!(vector::length(&counters.plots)<MAX_PLOTS, E_PLOT_LIMIT_EXCEEDED);

    let (found, _) = vector::index_of(&counters.plots, &plot_id);
    assert!(!found, E_PLOT_ALREADY_EXISTS);

    vector::push_back(&mut counters.plots, plot_id);
    counters.planted = counters.planted + 1;

    }

    public fun harvest(counters: &mut FarmCounters, plot_id: u8) {

        let (found, index) = vector::index_of(&counters.plots, &plot_id);
        assert!(found, E_PLOT_NOT_FOUND);

        vector::remove(&mut counters.plots, index);
        counters.harvested = counters.harvested + 1;
     }

    #[test]
    fun test_farm_flow(){
        let mut counters = new_counters();

        plant(&mut counters, 5);
        plant(&mut counters, 10);
        assert!(counters.planted == 2, 0);
        assert!(vector::length(&counters.plots) == 2, 1);

        harvest(&mut counters, 5);
        assert!(counters.harvested == 1, 2);
        assert!(vector::length(&counters.plots) == 1, 3);

        let(found, _) = vector::index_of(&counters.plots, &10);
        assert!(found, 4);
    }
}

