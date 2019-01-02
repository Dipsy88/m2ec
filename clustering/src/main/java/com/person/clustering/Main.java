package com.person.clustering;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.person.clustering.algorithm.AffinityPropagation;

public class Main {

//	private static String file = "value_avgWeight.txt";
	private static String file = "value.txt";
	public static void main(String[] arg) {
		read(file);
	}

	public static void read(String file) {
		List<String[]> list = new ArrayList<>();

		try (Stream<String> stream = Files.lines(Paths.get(file))) {
//			stream.forEach(System.out::println);

			list = stream.map(line -> line.split("\t")).collect(Collectors.toList());

		} catch (IOException e) {
			e.printStackTrace();
		}
//		double[][] matrix = convertMatrix(list);
		double[][] matrix = convertMatrixManual(list);
		AffinityPropagation affinityPropagation = new AffinityPropagation(matrix);
		List<AffinityPropagation.ClusterIds> clusterIdList = affinityPropagation.run();
		
		printClusters(clusterIdList);
	}

	public static double[][] convertMatrix(List<String[]> list) {
		double ret[][] = new double[list.size()][list.size()];
		int i = 0;
		for (String[] itemList : list) {
			int j = 0;
			for (String item : itemList) {
				ret[i][j] = Double.parseDouble(item);
				j++;
			}
			i++;
		}
		return ret;
	}

	// manually add 0 for i == j
	public static double[][] convertMatrixManual(List<String[]> list) {
		double ret[][] = new double[list.size()][list.size()];
		int i = 0;
		for (String[] itemList : list) {
			int j = 0;
			for (String item : itemList) {
				if (i == j)
					ret[i][j] = 0;
				else
					ret[i][j] = Double.parseDouble(item);
				j++;
			}
			i++;
		}
		return ret;
	}

	public static void printClusters(List<AffinityPropagation.ClusterIds> clusterIdList) {
		int i = 1;
		for (AffinityPropagation.ClusterIds clusterId : clusterIdList) {
			System.out.printf("Cluster %s is", i);
			System.out.println(clusterId.getDataCenterIdList());
			i++;
		}

	}

}
