#!/bin/bash
# Copyright (c) 2013 Yu-Jie Lin
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

W=$(tput cols)

for ((x=0; x<W; x++)); do
  R[x]=$RANDOM
  G[x]=$RANDOM
  B[x]=$RANDOM
done

while :; do
  for ((x=0; x<W; x++)); do
    # R
    ((
      _L = x         ? R[x - 1] : RANDOM,
      _R = x < W - 1 ? R[x + 1] : RANDOM,
      R[x] = (_L + R[x] + _R) / 3
    ))
    ((
      R[x] = RANDOM % 2
           ? R[x] * 11 / 10
           : R[x] *  9 / 10,
      R[x] = R[x] > 32767
           ? 32767
           : R[x]
    ))
    # G
    ((
      _L = x         ? G[x - 1] : RANDOM,
      _R = x < W - 1 ? G[x + 1] : RANDOM,
      G[x] = (_L + G[x] + _R) / 3
    ))
    ((
      G[x] = RANDOM % 2
           ? G[x] * 11 / 10
           : G[x] *  9 / 10,
      G[x] = G[x] > 32767
           ? 32767
           : G[x]
    ))
    # B
    ((
      _L = x         ? B[x - 1] : RANDOM,
      _R = x < W - 1 ? B[x + 1] : RANDOM,
      B[x] = (_L + B[x] + _R) / 3
    ))
    ((
      B[x] = RANDOM % 2
           ? B[x] * 11 / 10
           : B[x] *  9 / 10,
      B[x] = B[x] > 32767
           ? 32767
           : B[x]
    ))
    ((_R = R[x] * 6 / 32768))
    ((_G = G[x] * 6 / 32768))
    ((_B = B[x] * 6 / 32768))
    echo -ne "\e[48;5;$((16 + _R * 36 + _G * 6 + _B))m "
  done
  sleep 0.01
  echo
done
