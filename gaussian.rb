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

def gaussian_set(mean, sd, size)
  nums = []
  (size/2).to_i.times do
    nums.push *gaussian(mean, sd)
  end
  nums
end

def bin_nums(nums, binsize)
  data = {}
  nums.each do |num|
    val = floor_float(num, binsize)
    data[val] = 0 if data[val].nil?
    data[val] += 1
  end
  data
end

nums = gaussian_set(0, 1, 1000)
data = bin_nums(nums, 0.5)

p data.sort.to_h
