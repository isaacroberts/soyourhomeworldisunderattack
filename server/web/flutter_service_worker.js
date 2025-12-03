'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "fcef252418b3152b6beac8168bffef81",
"main.dart.js_98.part.js": "e9245977193d21b56405a1a353dc4874",
"main.dart.js_66.part.js": "de10739eec0b94558bdc12896c2a4739",
"main.dart.js_63.part.js": "291b93a0339065105675b61bc6ac3a3f",
"main.dart.js_32.part.js": "e0e19cfe9290fcbe3f28ea169b220346",
"main.dart.js_75.part.js": "b54e204c405d76616553fd7d0fbe8c09",
"main.dart.js_9.part.js": "50578449357e7787c1ce9eb641c5a4e1",
"flutter_bootstrap.js": "3404229f3af7cc54ba150f2071de6e0f",
"main.dart.js_61.part.js": "365908c7c957b6467ac08a53fe6de16f",
"main.dart.js_64.part.js": "cf39d0adcaa47b1d37522a2648cb4fe9",
"main.dart.js_60.part.js": "b2643df11c6e1d4e328bda4166b432b2",
"main.dart.js_102.part.js": "819f2ab8badba6af32b4268799e6738d",
"main.dart.js_76.part.js": "5ad90371399df4edd6c2919ab4378582",
"main.dart.js_106.part.js": "c7708f9e84cad2b3dbe9eb5d2b79de78",
"main.dart.js_62.part.js": "d8d858cb778f1dc6b4811c7f7718396a",
"main.dart.js_68.part.js": "2974a992fb1fe396d77d4335b7bd7f32",
"main.dart.js_83.part.js": "24ae992b836ff4fecaff4ebfe7e32e79",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "47cf7cf8f6b4d57f71ec04c000977fdd",
"main.dart.js_71.part.js": "ea53e4a600b15c0e61ab2d00c0936429",
"main.dart.js_41.part.js": "770e947fe4ac7ad1f6f5a72b80de287c",
"main.dart.js_50.part.js": "a644caa451f77568a5eda139a46439a7",
"main.dart.js_40.part.js": "31ce8eb9fd2dbd5fc958dce1be6a43ca",
"main.dart.js_113.part.js": "6e322799c4f5ef23f3d203201a4467aa",
"main.dart.js_101.part.js": "a4f12de481c75ed9f8cac8a4f69465f6",
"main.dart.js_30.part.js": "9d9a3e77b1277b042ecf1982e044ac4e",
"main.dart.js_128.part.js": "76186c062424bdca95b8b8ceac0a1364",
"main.dart.js_51.part.js": "343c43aa6aaccb0bb0319887487f14c5",
"main.dart.js_28.part.js": "06ab7ccd1979fb3fc7da51e2a657bba4",
"main.dart.js_29.part.js": "9490917fb6e5b8f786e5471e3bf73937",
"main.dart.js_7.part.js": "a454d73d268d089e2a10b89147a07951",
"main.dart.js_91.part.js": "a8c036044913455c8ecc4b1c6191a7f0",
"main.dart.js_8.part.js": "935bdf95b14d332c751440f524c6eaee",
"main.dart.js_25.part.js": "9bed4b48ebcd5f2ec4b7585896f694c5",
"main.dart.js_103.part.js": "f291249b70126349c206733f81d75500",
"main.dart.js_1.part.js": "e072165e7ee23b736bdc77727d7d2ab4",
"main.dart.js_3.part.js": "e109d21754b6c50477fc0900e300196b",
"main.dart.js_34.part.js": "1d220ab16aafe4b790a5dffe3ceec36b",
"main.dart.js_126.part.js": "06465f7fbbd55556fa80422ab2b78945",
"main.dart.js_22.part.js": "041bb8929a684b53446b1ca57d0a8207",
"main.dart.js_130.part.js": "8447fd8ae47fc99f7ff0be006b9a6f5c",
"main.dart.js_14.part.js": "281c71c390b071b4688f86a5330744f5",
"main.dart.js_49.part.js": "736fa41847f4c6eaf3916ce38657ad45",
"main.dart.js_20.part.js": "9cca7b4ed56a9156f9ede55fe6a8aacf",
"main.dart.js_118.part.js": "a2adaf6bbe5ce5513e2b56b848ce0f34",
"main.dart.js_105.part.js": "e9ce8d3b2edfb9978b0f3265816e843c",
"main.dart.js_6.part.js": "ccd09b3c2e7fe25354a9e2647cacad4d",
"main.dart.js_87.part.js": "ade5c282bfb77c18aa93a90c51e611cb",
"main.dart.js_46.part.js": "b1c5ed65e8d99c423b85d11010aad018",
"main.dart.js_16.part.js": "a3d711e27d50bdeacf0704c50022637b",
"main.dart.js_5.part.js": "58f06f258c5b8e5de11f5a46ff07f6ae",
"main.dart.js_57.part.js": "cb2c1135e874d03dc70b899f5b221b59",
"main.dart.js_82.part.js": "118f4419ea823d1cdb28603edaad44ba",
"main.dart.js_17.part.js": "5c5054db8ea4237a5a72e9f1f442415f",
"main.dart.js_36.part.js": "09bd0e015d912bce4153afdaf2af4ed0",
"main.dart.js_15.part.js": "4e111213f8051bdb30982589be89f32a",
"main.dart.js_31.part.js": "8291fb0a3aad7a1c1a56396a9d3ff223",
"main.dart.js_21.part.js": "5958ccfea86eca6f62d47273f24af06b",
"main.dart.js_10.part.js": "96e45992e5b423a866cc391e8cd2a7a0",
"main.dart.js_73.part.js": "721ebf69f29938c46853fb24e701f98f",
"main.dart.js_93.part.js": "6ed387d112248362bd34d154adb56811",
"main.dart.js_115.part.js": "231d00a134eb62204bc9709f46317a62",
"main.dart.js_119.part.js": "d06e9a3aaf44027a3bb550bfb81950a4",
"main.dart.js_54.part.js": "ed223dbd9fa94a39420c8f2616156227",
"main.dart.js_123.part.js": "8f7907b1bdaa78c2e54cdaf31db2cfcb",
"main.dart.js_38.part.js": "436e1c925e94d66062609136da1340bc",
"main.dart.js_117.part.js": "61b3f335e39780881ccf955714717652",
"main.dart.js_116.part.js": "ab660b30f07e6ba383fe5bb2fa41cd97",
"main.dart.js_74.part.js": "41d2891f56c9d409a29f8429fb6e7ea5",
"main.dart.js_125.part.js": "a5260219f0216479f63c91fd3ef61a36",
"main.dart.js_53.part.js": "bc06b8e03c36a5a079d11e5e43f97c3e",
"main.dart.js_96.part.js": "b10835375933cef8a9c2859b245d4dce",
"main.dart.js_81.part.js": "05daa61157c343a7a5187897a69ec32d",
"main.dart.js_19.part.js": "e55c1e280e0b8a1fb997f44034d25ad1",
"main.dart.js_18.part.js": "2ffcf711ce433fd61cbede40e33dd384",
"main.dart.js_84.part.js": "bca8e8c306a420ec68210fd5917b9e5e",
"main.dart.js_129.part.js": "038470f6a7e5438e4711970c1434e9e3",
"main.dart.js_42.part.js": "61b9612eef03ebe5174430ff13f48ee9",
"main.dart.js_55.part.js": "14a9c59d15bd0ee4bde53b1473f6a517",
"main.dart.js_107.part.js": "c8306b247355bdc2aa576a7987dc56ef",
"main.dart.js_44.part.js": "3471fb55cf5af512e34fcff15db738ca",
"main.dart.js_65.part.js": "c79e2778578ca6b750eefdcafe777913",
"main.dart.js_72.part.js": "65d92520e4a2ab514b692af0684d8266",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "0472bdd263dd3189bc4c721523149efb",
"main.dart.js_85.part.js": "551bc66bed75719b0abdced3ea2a6ae0",
"main.dart.js_108.part.js": "59e3776d94a901594fb8321f1e91a0e4",
"main.dart.js_59.part.js": "5aceae72d0ae007110119ce9c13f6357",
"main.dart.js_94.part.js": "38514005f3fb0d4eebe0c9004d2fd5bb",
"main.dart.js_89.part.js": "871b90a0da9a9f1fe3fa961257a99c05",
"main.dart.js_70.part.js": "9743860e0f6cb3c6566dfd9e08380b2b",
"main.dart.js_33.part.js": "795a561ee1af20e28c3ebb1219dbb7d3",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "6ad2fff7ad8516492352d80f0d0cf4ce",
"main.dart.js_24.part.js": "af938c394965241ad222c0e7ecd67a48",
"main.dart.js_48.part.js": "e21203155a6ffb403d3b83556c74aced",
"main.dart.js_92.part.js": "f6fb99283865918979234edf22a3c7bc",
"main.dart.js_110.part.js": "90cb765ae616b91e397492ac71408f5d",
"main.dart.js_104.part.js": "404ab82375e18c759fbe4ba1594d3422",
"main.dart.js_11.part.js": "efb06126fad4320e7d23d54ceb8666e2",
"main.dart.js_124.part.js": "05e8b07ff1387ecfacba60aacbefd685",
"index.html": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"/": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"main.dart.js_4.part.js": "77edfb95adb59e1d2222b999053f853d",
"main.dart.js_97.part.js": "b63200e520e0510deaa66cb1d28ba1a7",
"main.dart.js_26.part.js": "44e02f31522f98d8ebf57b062c6e0913",
"main.dart.js_47.part.js": "db7fe3625608214bf8b2acfaef3c1fcb",
"main.dart.js_127.part.js": "9dff5da0185198e0db696a39fa4c7187",
"main.dart.js_37.part.js": "0268e3087494a8eeefa2960769a6090c",
"main.dart.js_27.part.js": "58e31ceb79657fdcab98937bdd33d990",
"main.dart.js_99.part.js": "273ebcdbef7d6f85cba3b002f38320f1",
"main.dart.js_13.part.js": "7c079a44bec473b3a913421471458a29",
"main.dart.js_112.part.js": "c8215aaeae3755688747f2f4a0774ca7",
"main.dart.js_43.part.js": "73c62f8e9d753dc7cdd0efdde0c020f2",
"main.dart.js_39.part.js": "e47dc7edbac61145a72096ee4e45ba8c",
"assets/AssetManifest.bin": "a6577e5d7d240d8b978a617aa0d8c5b9",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "22e6d4a6ec4448617a9ba48d1e631669",
"assets/fonts/MaterialIcons-Regular.otf": "bc26c3e7e86c2e5ba7c669e61363e1bb",
"assets/FontManifest.json": "5bf5570bf3efc7b2862937a369b1b0df",
"assets/AssetManifest.json": "6c25bb8151b6906cb474f8555472ccaf",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "e949713f8bb3a755d44ac95a5a424214",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "2ea6b9fbdd05a01e66d92f9546dc5650",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "c006ce824e20bf958d9128d0f9fb3f93",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-hu.tex": "92da72f62c22676dd856f45c7f30ba82",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-de-1996.tex": "c0efcc10c68f3c2ff922a3dd5a9b4358",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-nl.tex": "46ac935aeabbbe857eadbfb5f9445591",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-nb.tex": "585baf64d316bded05e0f685790be077",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-cs.tex": "cda88f6a55299f107eefcae42bb37b96",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-it.tex": "2972a9b9706722ecaeb754d86cba46cf",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-fi.tex": "4f57e618128f460c6d398bfee48ff6d4",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-pt-pt.tex": "c578d81d3ce83cbb7f4836c28d46e60e",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-pt-br.tex": "c578d81d3ce83cbb7f4836c28d46e60e",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-ru.tex": "93c222e9f8cdc5e29e5cb7d3fef9f00c",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-es-419.tex": "9f711bf0669ae0dd7b625e46e7fc6666",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-en-us.tex": "a8e06b7542c94f360a1e3f9bec0cd07b",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-bg.tex": "62a46cbcf6eb76811b11b09f12d16cd5",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-tr.tex": "da38eba98b2f563d30e80602f3f1b175",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-es-es.tex": "9f711bf0669ae0dd7b625e46e7fc6666",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-ro.tex": "0b4d746603b42894a4d5f3cf952ff960",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-fr.tex": "4479446a11e1366b5a18e408bfbc3c19",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-el.tex": "c2f93558ffff093b2d9cbcecd0bbee9c",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-pl.tex": "58fa3d45b6c75194708646fba2dba354",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-sv.tex": "7c3936b4070535e7ca92a0223475d16a",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-da.tex": "c3c16b9bc1a0a4d5289b3caf71e01011",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/water_clouds.frag": "59c161d5b0140f2d2ba8901629fb2e86",
"assets/NOTICES": "cc84716e518289781593f4a3c093b606",
"main.dart.js_88.part.js": "94fe84670d2fd2eba599f39406ba81cb",
"main.dart.js_120.part.js": "0ff17d8ddf18f948e69cc15a5ad20bb1",
"main.dart.js_23.part.js": "4a379d568383949af5737742955d9b24",
"main.dart.js_121.part.js": "5a800c03f70d59c5d9f05a0ef63af55a",
"main.dart.js_67.part.js": "fb8ab50eb991ee45962c4a18b56b21af",
"main.dart.js_111.part.js": "05930c5ed36e2532794be770d93fb4a0",
"main.dart.js_114.part.js": "339b51c8c25bf9132b078b737a3086cd",
"main.dart.js_122.part.js": "dc60eb7b5caa019c57dafc07726d26df",
"main.dart.js_69.part.js": "0231a365242fd524b874c8f3b62d57e9",
"main.dart.js_100.part.js": "0f76f5067174138ded8b45cbcf5a5b39",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "3eee837183f35248f6c996c11760631d",
"main.dart.js_90.part.js": "c554209dcf885d277b9ef17192553bd2",
"main.dart.js_35.part.js": "00af3f9711d8a8a542d4c9b23297ab61",
"main.dart.js_52.part.js": "b960767ab421c301a71f3c0c55e4d4b3",
"main.dart.js_95.part.js": "2ad784d7ee83ae4b936e384a48e4771a",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "abb507d912fa1d927b874f88cf390708",
"main.dart.js_2.part.js": "eceb760ca1332864904b0cb77fa1c457",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "c8c3fcb5d396397515563cb2b075f4d6",
"main.dart.js_56.part.js": "83add867f97dea837624c91f61a711c6",
"main.dart.js_80.part.js": "6a96852b236632c21a5833c9afea16e0",
"main.dart.js_86.part.js": "5d0cb7e2ceccca531de113155a11e9de",
"main.dart.js_12.part.js": "7dc12b9c6bb955222bc5246ce8168cb7"};
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
