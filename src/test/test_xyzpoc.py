import sys
import unittest
from pathlib import Path
import time
path_root = Path(__file__).parents[1]
sys.path.append(str(path_root))
from xyzpoc import app  # noqa: E402


class XyzpocApiTest(unittest.TestCase):
    '''
    Test the test endpoint should return a message and a timestamp. Get current timestamp and compare
        example:
            application/json: {"message": "Automate all the things!", "timestamp": 1529729125}
    '''
    def test_1_test_endpoint(self):
        tester = app.test_client(self)
        response = tester.get('/test')
        time_diff = abs(response.json["timestamp"] - int(time.time()))
        self.assertEqual(response.status_code, 200)
        self.assertLess(time_diff, 5, "Time value difference > 5 seconds")
        self.assertEqual(response.json["message"], "Automate all the things!")


if __name__ == '__main__':
    unittest.main()
