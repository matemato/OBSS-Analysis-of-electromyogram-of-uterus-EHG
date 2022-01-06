function [early, late, term, preterm] = main()
    
    info = readtable('tpehgdb.smr', 'FileType', 'text');
    info.Properties.VariableNames = {'Record', 'Gestation', 'When', 'Group', 'Premature', 'Early'};

    early = [];
    late = [];
    term = [];
    preterm = [];

    files = dir('*.mat');
    for file = files'
        file.name
        entropy = getEntropy(file.name);
        n = regexp(file.name, 'm.mat');
        idx = find(ismember(info.Record, file.name(1:n-1)))
        if info.Early{idx} == 't'
            early = [early, [info.Gestation(idx);entropy]];
        else
            late = [late, [info.Gestation(idx);entropy]];
        end

        if info.Premature{idx} == 't'
            preterm = [preterm, [info.When(idx);entropy]];
        else
            term = [term, [info.When(idx);entropy]];
        end
    end

    scatter(early(1,:), early(2,:))
    hold on;
    scatter(late(1,:),late(2,:));
    hold on;
    xline(37);
    hold on;
    legend("early", "late")
    
    figure();
    scatter(term(1,:), term(2,:))
    hold on;
    scatter(preterm(1,:),preterm(2,:));
    hold on;
    xline(26);
    hold on;
    legend("term", "preterm")

    mean(early(2,:)) % 0.6050
    mean(late(2,:)) % 0.5513
    mean(term(2,:)) % 0.5858
    mean(preterm(2,:)) % 0.5423

    [h,p] = ttest2(early(2,:),late(2,:)) % h = 1, p = 0.0130
    [h,p] = ttest2(term(2,:),preterm(2,:)) % h = 0, p = 0.1814
end