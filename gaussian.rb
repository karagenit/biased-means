#!/usr/bin/env ruby

require 'gnuplotrb'
include GnuplotRB

def floor_float(val, lim)
  (val / lim).round * lim
end

def gaussian(mean, stddev)
  theta = 2 * Math::PI * Random.rand
  rho = Math.sqrt(-2 * Math.log(1 - Random.rand))
  scale = stddev * rho
  x = mean + scale * Math.cos(theta)
  y = mean + scale * Math.sin(theta)
  return x, y
end

nums = []

100.times do
  x, y = gaussian(0, 1)
  nums.push x
  nums.push y
end

data = {}

nums.each do |num|
  val = floor_float(num, 0.5)
  data[val] = 0 if data[val].nil?
  data[val] += 1
end

p data.sort.to_h
