function complexNumbers = generateComplexNumbers(n)
    % Check if n is even
    if mod(n, 2) ~= 0
        error('Input must be an even number for pairs of conjugates.');
    end

    % Generate random magnitudes and angles for the first half
    magnitudes = sqrt(rand(1, n/2));
    angles = sort(rand(1, n/2) * 2 * pi);

    % Create complex numbers in polar form
    polarComplex = magnitudes .* exp(1i * angles);

    % Duplicate and conjugate to get pairs of conjugates
    complexNumbers = [polarComplex, conj(polarComplex)];

    % Shuffle the array for randomness
    complexNumbers = complexNumbers(randperm(n));

    % Display the complex numbers
%     disp('Generated complex numbers:');
%     disp(complexNumbers);
    
    % Plot the complex numbers on the unit circle
%     figure;
%     scatter(real(complexNumbers), imag(complexNumbers), 'filled');
%     hold on;
%     th = linspace(0, 2*pi, 100);
%     plot(cos(th), sin(th), '--', 'Color', [0.5 0.5 0.5]);
%     axis equal;
%     title('Complex Numbers on the Unit Circle');
%     xlabel('Real Part');
%     ylabel('Imaginary Part');
%     grid on;
%     hold off;
end
