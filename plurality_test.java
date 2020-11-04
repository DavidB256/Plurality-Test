import java.util.Arrays;
import java.util.Random;

public class plurality_test {
	static Random r = new Random();
	
	public static void main(String[] args) {
		r.setSeed(1);
		// iterations is the number of times that each simulation will be run
		
		// iterations should be at least 10^4, and can be increased for greater simulation
		// accuracy at the cost of greater runtime
		int iterations = (int) Math.pow(10, 4);
		// elements of sizes are the number of voters in a given election
		int[] sizes = {(int) Math.pow(10, 1), (int) Math.pow(10, 2), (int) Math.pow(10, 4),
				(int) Math.pow(10, 6)};
		// elements of cand_counts are the number of candidates in a given election
		int[] cand_counts = {2, 3, 5, 10, 20};
		
		// run simulations for every pairing of elements in sizes and cand_counts and
		// print output
		int critical_val;
		for (int size : sizes) {
			for (int count : cand_counts) {
				// call get_critical_val at a significance level of 0.05, i.e. 95%
				// confidence
				critical_val = get_critical_val(iterations, size, count, .05);
				System.out.println(critical_val);
			}
			System.out.println();
		}
	}
	
	// simulate election, return critical value
	public static int get_critical_val(int iterations, int size, int cand_count, double alpha) {
		int[] diffs = new int[iterations];
		
		// run simulation
		int[] votes = new int[cand_count];
		for (int k=0; k<iterations; k++) {
			// clear vote counts before simulating new election
			for (int i=0; i<cand_count; i++) {
				votes[i] = 0;
			}
			// simulate new election
			for (int i=0; i<size; i++) {
				votes[r.nextInt(cand_count)]++;
			}
			// record difference in votes between candidate with most and second-most
			// votes
			Arrays.sort(votes);
			diffs[k] = votes[cand_count-1] - votes[cand_count-2];
		}
		
		// return 
		Arrays.sort(diffs);
		int critical_val = diffs[(int) (iterations * (1.0 - alpha))];
		return critical_val;
	}
}


