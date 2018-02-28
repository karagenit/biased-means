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

p true_individuals
p true_pooled
