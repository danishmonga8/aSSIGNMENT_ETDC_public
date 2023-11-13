clc; clear all; close all;

% Define the 11 offers
offers = {
    'One month OTT platform subscription',
    'Free two-time two-wheeler servicing',
    'Rs. 1000 online shopping gift cards and gift vouchers',
    '18 months subscription for music streaming services',
    '3% discount on Rs. 20,000 tour package',
    'Up to 3% off on the Rs. 20,000 trek package',
    'Rs. 500 food coupons and offers in restaurants',
    '10% or up to 500 discounts on booking flights, whichever is less',
    'One-month magazine subscription',
    'Free one-time complete body medical check-up service'
};

% Generate all possible pairs of offers
numOffers = numel(offers);
offerPairs = cell(numOffers*(numOffers-1)/2, 2); % Preallocate memory for efficiency
pairIdx = 1;
for i = 1:numOffers
    for j = i+1:numOffers
        offerPairs(pairIdx, :) = {offers{i}, offers{j}};
        pairIdx = pairIdx + 1;
    end
end

% Simulate random ratings for each pair (between 1 and 7)
ratings = randi([1, 7], size(offerPairs, 1), 1);

% Combine pairs and ratings
ratedPairs = [offerPairs, num2cell(ratings)];

% Sort the rated pairs by rating in descending order
ratedPairs = sortrows(ratedPairs, -3);

% Display the top-rated pairs
for i = 1:size(ratedPairs, 1)
    fprintf('Pair %d:\n', i);
    fprintf('Offer 1: %s\n', ratedPairs{i, 1});
    fprintf('Offer 2: %s\n', ratedPairs{i, 2});
    fprintf('Rating: %d\n\n', ratedPairs{i, 3});
end

% Save the results in Excel format
T = cell2table(ratedPairs, 'VariableNames', {'Offer_1', 'Offer_2', 'Rating'});
writetable(T, 'RatedPairs.xlsx');
