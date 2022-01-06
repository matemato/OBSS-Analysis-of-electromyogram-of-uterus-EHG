function entropy = getEntropy(record)
    load(record);
    sig = val(10,:);

    m = 3;
    r = 0.15;

    entropy = sampleEntropy(sig, m ,r);
end