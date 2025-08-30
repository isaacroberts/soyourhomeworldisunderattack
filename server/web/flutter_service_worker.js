'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "2618802d4010275e2c5183b8cd78d1f9",
"main.dart.js_66.part.js": "267730b619127ee908246d551fde1118",
"main.dart.js_63.part.js": "b6ca21b844e5db1302e6ec635e21d917",
"main.dart.js_32.part.js": "5e085f6008a828c5b9b81906b37c0b3e",
"main.dart.js_9.part.js": "8f52cf47285d68446d016dec5bec97f1",
"flutter_bootstrap.js": "bd714b5ce0015a321b5970ed3cb8e555",
"main.dart.js_61.part.js": "659220a4c2603e2d4ded948b5231d728",
"main.dart.js_64.part.js": "03969f6963efe22e8388543049e9e343",
"main.dart.js_60.part.js": "cda996f1c232c2dd39a230c907a1edda",
"main.dart.js_76.part.js": "f340173f73a4476c2a39f036a6954675",
"main.dart.js_62.part.js": "74e26b3583cc1f5e2f9c1f33d43271b7",
"main.dart.js_68.part.js": "9284069cfc510b73251a42087d75f869",
"main.dart.js_83.part.js": "4846193377d19c0df57472b43bb87a37",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "6a51ce39dd629f06e2a0a93028473136",
"main.dart.js_41.part.js": "eda74215c9e957aec29d8735aff7e4ff",
"main.dart.js_50.part.js": "45466bc4a93118c4eaa5b80bccddab55",
"main.dart.js_40.part.js": "30e8a2410d87851c8ea250728eb7ffdd",
"main.dart.js_30.part.js": "a0acbb6e3ede4bb8daddcb3e9999eded",
"main.dart.js_28.part.js": "361cb0136572cd8dd032c105a91629f3",
"main.dart.js_29.part.js": "59cf2e5bae9cd6440cb2d4b409277f99",
"main.dart.js_7.part.js": "67ff731a81876d8d3532a28ca7ef4c30",
"main.dart.js_91.part.js": "5c6b82511f8f184a5587ed24accde2c1",
"main.dart.js_8.part.js": "fc89cb29ac3870c5bdb3377909b09fff",
"main.dart.js_25.part.js": "8b42c21fe2cbea7534ec9c6d9f4e5bc8",
"main.dart.js_1.part.js": "32d30614abc47c3a89a4271f70b7413a",
"main.dart.js_3.part.js": "1f31af2d65c6a72e5d8d652728cd3b18",
"main.dart.js_34.part.js": "5805bba90af9c6d92d49711342991155",
"main.dart.js_22.part.js": "907aa67dff6de8d7fba7709e6d4d17ea",
"main.dart.js_14.part.js": "4cb2d7b68cfc45dbd2651ce00f550212",
"main.dart.js_49.part.js": "e679a10eade1053a390af8900bef664a",
"main.dart.js_20.part.js": "512e1064c6d98afcd2219c9d43e7163b",
"main.dart.js_6.part.js": "0f4f15cd41ff1440fd229b5a1dc856ba",
"main.dart.js_87.part.js": "40085438e07aa8283b79f30b4605ed9b",
"main.dart.js_5.part.js": "2f26224c9677b15c1fa4f097e571f4f3",
"main.dart.js_57.part.js": "9bfc3831f9e47f82c49ed6b38b9b5c95",
"main.dart.js_82.part.js": "f49afda01c2ba859df4ee5e2cafeecb1",
"main.dart.js_36.part.js": "9bea763a6ac4f92e671433af84311281",
"main.dart.js_15.part.js": "3ba724dbe9dc7698bfb8ffdc2c522388",
"main.dart.js_31.part.js": "2031e2bc8279e8b3e22dd3624f40d0c9",
"main.dart.js_10.part.js": "34a6ede45367b3391c62b8ef197653c4",
"main.dart.js_93.part.js": "244bf65e01f259de1309098536ff22cf",
"main.dart.js_54.part.js": "e5229ab02f965a6da3b21aa1fdfa25d3",
"main.dart.js_38.part.js": "d3f032cb3f2e4dd9f0e1a6737f87cada",
"main.dart.js_74.part.js": "9078dd64ae24b725b3b66c58049f8b83",
"main.dart.js_53.part.js": "78f6115f779baf02d6310a067c979161",
"main.dart.js_81.part.js": "7127d246d1078f44e8ce059d7765b07e",
"main.dart.js_19.part.js": "2117733aad85f50fd281303144f94679",
"main.dart.js_18.part.js": "611ab7479b9b8c5beddfa60f90c0bd9c",
"main.dart.js_84.part.js": "0bd00655cc3a13ae01ad546773b21402",
"main.dart.js_55.part.js": "0b978633d7e2ebcf455e6b330fa96632",
"main.dart.js_44.part.js": "57027e79303ac1a3f79e825c8e7358ff",
"main.dart.js_65.part.js": "74081d8910e6b8d00f4b2d3abc1ef00c",
"main.dart.js_72.part.js": "dcfd285f4095b1b391d957224e7445e5",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "a89c4e7e2412828b2ad672c02855e9e0",
"main.dart.js_85.part.js": "d78007883123ff056852ab987c1e4d13",
"main.dart.js_59.part.js": "dfb0f5e6879bef7598df0b6c406b23ab",
"main.dart.js_94.part.js": "8e7c4f94f946c0f81b5beacbc1b35152",
"main.dart.js_89.part.js": "7c9b2bc1c9aac235bbdb56d0d69fbc41",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_24.part.js": "261f94c7f38485f6d4a4157432568299",
"main.dart.js_48.part.js": "e27ea2fb82e50f23c0fd578d8b14aa9d",
"main.dart.js_92.part.js": "0f88a403b5fd830e928689d41f541a2a",
"main.dart.js_11.part.js": "7e8238359623b9b5dd00cf3b9810a647",
"index.html": "c6f08a37d8b316ab9e74ba27f548c182",
"/": "c6f08a37d8b316ab9e74ba27f548c182",
"main.dart.js_4.part.js": "d1a20ac03843c3672a2a19842c7288b3",
"main.dart.js_27.part.js": "9a2785bc160ccb371416bb3a98b18a58",
"main.dart.js_13.part.js": "ae7e4542a727ddba7a593eb3cd4835d9",
"main.dart.js_43.part.js": "4fb88155710cdf811291a7f3d3ec2b01",
"main.dart.js_39.part.js": "c74ed722270878eea5023f6899d2d6fe",
"assets/AssetManifest.bin": "cd5d7abf98054bdf8a9d1c8eb941fcd0",
"assets/cargoship/iconttf/RpgAwesome.ttf": "99232001effca5cf2b5aa92cc3f3e892",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "50204dc89005b799bf8b48ba16a1d3d7",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "845139c6a2d4e9245bbe46e978b2be42",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "9ad9230d01f370a8d82269427aa3a406",
"main.dart.js_67.part.js": "486a3b7704333534e73cee0d1de85d83",
"main.dart.js_69.part.js": "7b8ad3cd11c920ffa45e76c9b6477073",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "d6a58ed591099ba019976e2a2b32768c",
"main.dart.js_90.part.js": "c378891d87e6a62ac51f3516db567127",
"main.dart.js_35.part.js": "7b95ed6cfe27aec9eee149c00a1207cb",
"main.dart.js_52.part.js": "7c23597d11263fc77d57b4a4c85d569b",
"main.dart.js_95.part.js": "6c70d0a888f1030689bb6a7e47398891",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_2.part.js": "0d71c066a4060fa9e8baa7a3af22c5c8",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "7ef21f1ce41572741ac7f534cb271afc",
"main.dart.js_56.part.js": "d2ea787c7f8def205baf4be0e30fabaa",
"main.dart.js_86.part.js": "ddb1523239e1c4fb313662cde0f3f4a1"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
