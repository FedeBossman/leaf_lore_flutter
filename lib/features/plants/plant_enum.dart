import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/core/extension/build_context_extensions.dart';

enum CareLevel {
  low,
  medium,
  high,
}

extension CareLevelExtension on CareLevel {
  String loc(BuildContext context) {
    switch (this) {
      case CareLevel.low:
        return context.loc.careLevel_low;
      case CareLevel.medium:
        return context.loc.careLevel_medium;
      case CareLevel.high:
        return context.loc.careLevel_high;
    }
  }
}

enum SunlightRequirement {
  fullSun,
  partialShade,
  fullShade,
}
extension SunlightRequirementExtension on SunlightRequirement {
  String loc(BuildContext context) {
    switch (this) {
      case SunlightRequirement.fullSun:
        return context.loc.sunlightRequirement_fullSun;
      case SunlightRequirement.partialShade:
        return context.loc.sunlightRequirement_partialShade;
      case SunlightRequirement.fullShade:
        return context.loc.sunlightRequirement_fullShade;
    }
  }
}

enum WateringFrequency {
  daily,
  weekly,
  biweekly,
  monthly,
}

extension WateringFrequencyExtension on WateringFrequency {
  String loc(BuildContext context) {
    switch (this) {
      case WateringFrequency.daily:
        return context.loc.wateringFrequency_daily;
      case WateringFrequency.weekly:
        return context.loc.wateringFrequency_weekly;
      case WateringFrequency.biweekly:
        return context.loc.wateringFrequency_biweekly;
      case WateringFrequency.monthly:
        return context.loc.wateringFrequency_monthly;
    }
  }
}

enum FertilizationFrequency {
  weekly,
  monthly,
  quarterly,
  yearly,
}

extension FertilizationFrequencyExtension on FertilizationFrequency {
  String loc(BuildContext context) {
    switch (this) {
      case FertilizationFrequency.weekly:
        return context.loc.fertilizationFrequency_weekly;
      case FertilizationFrequency.monthly:
        return context.loc.fertilizationFrequency_monthly;
      case FertilizationFrequency.quarterly:
        return context.loc.fertilizationFrequency_quarterly;
      case FertilizationFrequency.yearly:
        return context.loc.fertilizationFrequency_yearly;
    }
  }
}

enum SoilType {
  loamy,
  sandy,
  clay,
  peaty,
  chalky,
  wellDraining
}

extension SoilTypeExtension on SoilType {
  String loc(BuildContext context) {
    switch (this) {
      case SoilType.loamy:
        return context.loc.soilType_loamy;
      case SoilType.sandy:
        return context.loc.soilType_sandy;
      case SoilType.clay:
        return context.loc.soilType_clay;
      case SoilType.peaty:
        return context.loc.soilType_peaty;
      case SoilType.chalky:
        return context.loc.soilType_chalky;
      case SoilType.wellDraining:
        return context.loc.soilType_wellDraining;
    }
  }
}

enum PotSize {
  small,
  medium,
  large,
  extraLarge,
}

extension PotSizeExtension on PotSize {
  String loc(BuildContext context) {
    switch (this) {
      case PotSize.small:
        return context.loc.potSize_small;
      case PotSize.medium:
        return context.loc.potSize_medium;
      case PotSize.large:
        return context.loc.potSize_large;
      case PotSize.extraLarge:
        return context.loc.potSize_extraLarge;
    }
  }
}

enum HumidityRequirement {
  low,
  medium,
  high,
}

extension HumidityRequirementExtension on HumidityRequirement {
  String loc(BuildContext context) {
    switch (this) {
      case HumidityRequirement.low:
        return context.loc.humidityRequirement_low;
      case HumidityRequirement.medium:
        return context.loc.humidityRequirement_medium;
      case HumidityRequirement.high:
        return context.loc.humidityRequirement_high;
    }
  }
}
