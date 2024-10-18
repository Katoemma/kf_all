import 'package:airtable_crud/airtable_plugin.dart';

String apikey =
    'patsRqLsX7Qj6YTEn.265a5d5b26e78cb3a99489517a9386d1154117ce66542845de3963c216303123';

String nurserybaseId = 'app9yul6FMnVUm7L4';
String currentNurserybaseId = 'appApXI0jgwCRGrB0';
String gardenbaseId = 'appJBOIeM2ZA5nhnV';
String currentGardenbaseId = 'appoW7X8Lz3bIKpEE';

AirtableCrud nurseryBase = AirtableCrud(apikey, nurserybaseId);
AirtableCrud gardenBase = AirtableCrud(apikey, gardenbaseId);
AirtableCrud currentNurseryBase = AirtableCrud(apikey, currentNurserybaseId);
AirtableCrud currentGardenBase = AirtableCrud(apikey, currentGardenbaseId);
