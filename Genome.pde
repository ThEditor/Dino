class Gene {
  int connection_from_layer;
  int source_neuron_id;
  int target_neuron_id;
  float weight;
  
  Gene() {
    source_neuron_id = (int) random(0, 7);
    connection_from_layer = (random(1) < 0.5) ? 0 : 1;
    if (connection_from_layer == 0) {
      // connecting inputs to hidden
      target_neuron_id = (int) random(0, 7);
    } else {
      target_neuron_id = (int) random(0, 3);
    }
    weight = random(-1, 1);
  }
}

class Genome {
  int length;
  ArrayList<Gene> genes;
  float[] hidden_layer_bias;
  float[] output_layer_bias;
  
  Genome() {
    length = 20;
    genes = new ArrayList<Gene>();
    for (int i = 0; i < length; i++) {
      genes.add(new Gene());
    }
    hidden_layer_bias = random_vector(7);
    output_layer_bias = random_vector(3);
  }

  Genome copy(){
    Genome copy = new Genome();
    for (int i = 0; i < length; i++){
      copy.genes.set(i, genes.get(i));
    }
    for (int i = 0; i < 7; i++){
      copy.hidden_layer_bias[i] = hidden_layer_bias[i];
    }
    for (int i = 0; i < 2; i++){
      copy.output_layer_bias[i] = output_layer_bias[i];
    }
    return copy;
  }
  
  Genome mutate() {
    // Start with a copy of the genome (this one, copy)
    Genome mutated_genome = copy();
    // But change some of the genes for new random ones
    int amount_of_mutations = (int)random(1, 5);
    for (int i = 0; i < amount_of_mutations; i++){
      int index = (int)random(0, length);
      mutated_genome.genes.set(index, new Gene());
    }
    return mutated_genome;
  }

  Genome crossover(Genome anotherGenome) {
    // Start with a copy of the genome
    Genome crossed_genome = copy();
    // But change some of the genes for some of the other genome's genes
    int amount_of_crossovers = (int)random(1, 5);
    for (int i = 0; i < amount_of_crossovers; i++){
      int index = (int)random(0, length);
      crossed_genome.genes.set(index, anotherGenome.genes.get(index));
    }
    return crossed_genome;
  }
}
