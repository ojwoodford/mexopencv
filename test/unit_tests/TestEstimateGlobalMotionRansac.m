classdef TestEstimateGlobalMotionRansac
    %TestEstimateGlobalMotionRansac

    methods (Static)
        function test_1
            im1 = cv.imread(fullfile(mexopencv.root(),'test','RubberWhale1.png'), 'Grayscale',true);
            im2 = cv.imread(fullfile(mexopencv.root(),'test','RubberWhale2.png'), 'Grayscale',true);
            pt1 = cv.goodFeaturesToTrack(im1);
            pt2 = cv.goodFeaturesToTrack(im2);
            models = {'Translation', 'TranslationAndScale', 'Rotation', ...
                'Rigid', 'Similarity', 'Affine'};
            for i=1:numel(models)
                [M,rmse,ninliers] = cv.estimateGlobalMotionRansac(pt1, pt2, ...
                    'MotionModel',models{i}, 'RansacParams',models{i});
                validateattributes(M, {'numeric'}, {'2d', 'size',[3 3]});
                validateattributes(rmse, {'numeric'}, {'scalar', 'real'});
                validateattributes(ninliers, {'numeric'}, {'scalar', 'integer'});
            end
        end

        function test_error_1
            try
                cv.estimateGlobalMotionRansac();
                throw('UnitTest:Fail');
            catch e
                assert(strcmp(e.identifier,'mexopencv:error'));
            end
        end
    end
end
