import numpy as np
from os.path import dirname, abspath

deep_sort_requirements = True

from bin.deep_sort.deep_sort import nn_matching
from bin.deep_sort.deep_sort.tracker import Tracker
from bin.deep_sort.deep_sort import detection as dt
from bin.deep_sort.application_util import preprocessing
from bin.deep_sort.tools import generate_detections as gen_dt


class Deep_Sort():
    encoder = gen_dt.create_box_encoder(
        dirname(abspath(__file__)) + "/resources/networks/mars-small128.pb")

    def __init__(self):
        if not deep_sort_requirements:
            print("ERROR : deep sort or sort submodules not found for tracking please run :"
                  "\tgit submodule update --init --recursive"
                  "\tENDING")


        self.metric  = nn_matching.NearestNeighborDistanceMetric("cosine", 0.2, 100)
        self.tracker = Tracker(self.metric)
        pass

    def track(self, results ,imgcv):

        if results is None:
            return False

        detection_results   = []
        track_results       = []
        detection_scores    = []

        for result in results:
            left    = result['topleft']['x']  # x1
            top     = result['topleft']['y']  # y1
            right   = result['bottomright']['x']  # x2
            bot     = result['bottomright']['y']  # y2
            confidence     = result["confidence"]  # y2


            detection_results.append(np.array([left, top, right - left, bot - top]).astype(np.float64))
            detection_scores.append(confidence)

        detection_results   = np.array(detection_results)
        detection_scores    = np.array(detection_scores)
        features            = Deep_Sort.encoder(imgcv, detection_results.copy())

        detections = [
            dt.Detection(bbox, score, feature) for bbox, score, feature in
            zip(detection_results, detection_scores, features)]

        boxes   = np.array([d.tlwh for d in detections])
        scores  = np.array([d.confidence for d in detections])
        indices = preprocessing.non_max_suppression(boxes, 0.1, scores)

        detections = [detections[i] for i in indices]
        self.tracker.predict()
        self.tracker.update(detections)


        for track in self.tracker.tracks:
            if not track.is_confirmed() or track.time_since_update > 1:
                continue
            bbox = track.to_tlwh()

            track_results.append({
                        "label": track.track_id,
                        "confidence": -1,
                        "topleft": {"x": bbox[0], "y": bbox[1]},
                        "bottomright": {"x": bbox[0]+bbox[2], "y": bbox[1]+bbox[3]}
                    })


        return track_results
