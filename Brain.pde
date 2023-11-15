class Brain {
  
  float[] inputs;
  float[] outputs = {0, 0, 0};
  float[][] hidden_layer_weights;
  float[] hidden_layer_bias;
  float[] hidden_outputs;
  float[][] output_layer_weights;
  float[] output_layer_bias;
  
  Brain(Genome genome) {
    hidden_layer_weights = zeroes_matrix(7,7);
    output_layer_weights = zeroes_matrix(3,7);
    for (Gene gene : genome.genes) {
      if (gene.connection_from_layer == 0) {
        hidden_layer_weights[gene.target_neuron_id][gene.source_neuron_id] = gene.weight;
      } else {
        output_layer_weights[gene.target_neuron_id][gene.source_neuron_id] = gene.weight;
      }
    }
    hidden_layer_bias = genome.hidden_layer_bias;
    output_layer_bias = genome.output_layer_bias;
  }
  
  void forward_feed(float[] input_layer_values) {
     inputs = input_layer_values;
     hidden_outputs = matrix_vector_multiplication(hidden_layer_weights, input_layer_values);
     for (int i = 0; i < hidden_outputs.length; i++) {
       hidden_outputs[i] += hidden_layer_bias[i];
       hidden_outputs[i] = ReLU(hidden_outputs[i]);
     }
     outputs = matrix_vector_multiplication(output_layer_weights, hidden_outputs);
      for (int i = 0; i < outputs.length; i++) {
        outputs[i] += output_layer_bias[i];
        outputs[i] = ReLU(outputs[i]);
      }
  }

  float ReLU(float x) {
    return max(0, x);
  }
}
