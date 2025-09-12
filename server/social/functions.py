

class User:
    def __init__(self, id):
        self.id = id
        self.requests = []
        self.trust = -50

    def check(self):
        # check numpy
        # req = np.array(self.requests)
        # variability = ...
        # precision = ...
        # randomness = ...

        # self.trust += ...

        # if variability < k and precision < z and randomness < y
        return True

users = {}


def check_user_id(id):
    if id in users:
        return users[id].check()
    else:
        return False

def get_chapter_socials(request, chapter):
    data = request.POST

    chapter = data['ch']
    uid = data['uid']
    is_human = check_user_id(uid)

    

    return JsonResponse({})
