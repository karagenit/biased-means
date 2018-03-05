#!/usr/bin/env ruby

require_relative 'gaussian.rb'
require 'descriptive_statistics'

INDIVIDUALS=50

def misplacements(true_vals, sample_vals)
  count = 0
  (0...true_vals.size).each do |i|
    count += 1 if true_vals[i][:index] != sample_vals[i][:index]
  end
  count
end

true_individuals = []

(0...INDIVIDUALS).each do |i|
  true_individuals[i] = { index: i, mean: Random.rand * 100, sd: Random.rand * 10 }
end

true_pooled = {}
true_pooled[:mean] = true_individuals.map{ |ind| ind[:mean] }.mean
true_pooled[:sd]   = true_individuals.map{ |ind| ind[:mean] }.standard_deviation

true_order = true_individuals.sort_by { |ind| ind[:mean] }

######## BEGIN SAMPLE CALCULATIONS ########

mean_rank_misplacements = []
biased_mean_misplacements = []

(0..1000).each do |trial|

  print "Progress: #{ (100 * trial / 1000).round }%     \r"

  sample_individuals = []

  (0...INDIVIDUALS).each do |i|
    set = gaussian_set(true_individuals[i][:mean], true_individuals[i][:sd], Random.rand * 90 + 10)
    sample_individuals[i] = { index: i, mean: set.mean, sd: set.standard_deviation, n: set.length }
  end

  sample_pooled = {}
  sample_pooled[:mean] = sample_individuals.map{ |ind| ind[:mean] }.mean
  sample_pooled[:sd]   = sample_individuals.map{ |ind| ind[:mean] }.standard_deviation
  sample_pooled[:n]    = sample_individuals.inject(0){ |sum, ind| sum + ind[:n] }

  mean_rank_order = sample_individuals.sort_by { |ind| ind[:mean] }

  mean_rank_misplacements.push misplacements(true_order, mean_rank_order)

  biased_mean_order = sample_individuals.sort_by do |ind|
    #sample_dev = ind[:sd] / Math.sqrt(ind[:n])
    #pooled_dev = sample_pooled[:sd] / Math.sqrt(sample_pooled[:n])
    #ratio = pooled_dev/sample_dev

    ratio = ind[:sd] / sample_pooled[:sd]

    biased_mean = (ind[:mean] * (1-ratio)) + (sample_pooled[:mean] * (ratio))
  end

  biased_mean_misplacements.push misplacements(true_order, biased_mean_order)
end

puts ""
puts mean_rank_misplacements.mean
puts biased_mean_misplacements.mean
