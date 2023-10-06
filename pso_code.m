
numParticles = 30;
numDimensions = 2;
maxIterations = 100;
c1 = 2; 
c2 = 2; 
w = 0.7; 
xMin = -10; 
xMax = 10; 
% particles and velocities
particles = xMin + (xMax - xMin) * rand(numParticles, numDimensions);
velocities = zeros(numParticles, numDimensions);
personalBest = particles;
globalBest = particles(1, :);
globalBestValue = objectiveFunction(globalBest);
%while loop
iteration = 1;
while iteration <= maxIterations
    for i = 1:numParticles
        %current particle's value
        currentValue = objectiveFunction(particles(i, :));
        % Update personal best
        if currentValue < objectiveFunction(personalBest(i, :))
            personalBest(i, :) = particles(i, :);
        end
        % Update global best
        if currentValue < globalBestValue
            globalBest = particles(i, :);
            globalBestValue = currentValue;
        end
        r1 = rand(1, numDimensions);
        r2 = rand(1, numDimensions);
        velocities(i, :) = w * velocities(i, :) + c1 * r1 .* (personalBest(i, :) - particles(i, :)) + c2 * r2 .* (globalBest - particles(i, :));
        particles(i, :) = particles(i, :) + velocities(i, :);
        particles(i, :) = max(particles(i, :), xMin);
        particles(i, :) = min(particles(i, :), xMax);
    end
    fprintf('Iteration %d: Best Value = %.14f\n', iteration, globalBestValue);
    iteration = iteration + 1;
end
fprintf('Optimization finished.\n');
fprintf('Global Best Solution: %.14f\n', globalBest);
fprintf('Global Best Value: %.14f\n', globalBestValue);
