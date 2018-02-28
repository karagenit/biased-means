#!/usr/bin/env ruby

require_relative 'gaussian.rb'
require 'descriptive_statistics'

INDIVIDUALS=10

true_individuals = []

(0...INDIVIDUALS).each do |i|
  true_individuals[i] = { mean: Random.rand * 100, sd: Random.rand * 10 }
end

true_pooled = {}
true_pooled[:mean] = true_individuals.map{ |ind| ind[:mean] }.mean
true_pooled[:sd]   = true_individuals.map{ |ind| ind[:mean] }.standard_deviation

sample_individuals = []

(0...INDIVIDUALS).each do |i|
  sample_individuals[i] = gaussian_set(true_individuals[i][:mean], 
                                       true_individuals[i][:sd], Random.rand * 50 + 5)
end

(0...INDIVIDUALS).each do |i|
  puts "Sample Mean: #{sample_individuals[i].mean} Real Mean: #{true_individuals[i][:mean]}"
end
