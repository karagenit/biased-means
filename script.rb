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

sample_individuals = []

(0...INDIVIDUALS).each do |i|
  set = gaussian_set(true_individuals[i][:mean], true_individuals[i][:sd], Random.rand * 90 + 10)
  sample_individuals[i] = { index: i, mean: set.mean, sd: set.standard_deviation }
end

mean_rank_order = sample_individuals.sort_by { |ind| ind[:mean] }

puts misplacements(true_order, mean_rank_order)
