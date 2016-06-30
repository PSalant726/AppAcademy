def measure (n = 1, &prc)
    start_time = Time.now
    n.times { prc.call }
    (Time.now - start_time) / n
end