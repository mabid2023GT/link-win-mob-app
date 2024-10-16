import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_appointment_model.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class ServiceProviderAppointmentOverview extends StatefulWidget {
  const ServiceProviderAppointmentOverview({super.key});

  @override
  State<ServiceProviderAppointmentOverview> createState() =>
      _ServiceProviderAppointmentOverviewState();
}

class _ServiceProviderAppointmentOverviewState
    extends State<ServiceProviderAppointmentOverview> {
  final List<ServiceProvidersAppointmentModel> _listOfAppointments = [
    ServiceProvidersAppointmentModel(
      providerName: 'Ali Krabo',
      category: 'Plumbing',
      date: '18/10/2024',
      time: '14:00',
      isCompleted: false,
      rating: 0,
    ),
    ServiceProvidersAppointmentModel(
      providerName: 'Hado Krum',
      category: 'House Cleaning',
      date: '28/10/2024',
      time: '10:00',
      isCompleted: true,
      rating: 0,
    ),
    ServiceProvidersAppointmentModel(
      providerName: 'David Krite',
      category: 'Electrical Work',
      date: '22/10/2024',
      time: '12:30',
      isCompleted: false,
      rating: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        double bottomPad = maxSize.height * 0.1;
        double topPad = maxSize.height * 0.025;
        Size titleSize = Size(maxSize.width * 0.9, maxSize.height * 0.1);
        Size numOfAppointmentsSize =
            Size(maxSize.width * 0.9, maxSize.height * 0.075);
        Size appointmentWidgetSize =
            Size(maxSize.width * 0.9, maxSize.height * 0.4);

        return Padding(
          padding: EdgeInsets.only(top: topPad, bottom: bottomPad),
          child: Container(
            width: maxSize.width,
            height: maxSize.height,
            decoration: BoxDecoration(
              color: kHeaderColor,
              borderRadius: BorderRadius.circular(maxSize.width * 0.05),
              border: Border.all(color: kBlack, width: 1),
            ),
            child: SingleChildScrollView(
              child: _body(
                  titleSize, numOfAppointmentsSize, appointmentWidgetSize),
            ),
          ),
        );
      },
    );
  }

  _body(
      Size titleSize, Size numOfAppointmentsSize, Size appointmentWidgetSize) {
    return Column(
      children: [
        _title(titleSize),
        _numOfAppointments(numOfAppointmentsSize),
        ..._listOfAppointments.map(
          (appointment) => Column(
            children: [
              _appointmentWidget(appointment, appointmentWidgetSize),
              SizedBox(
                height: appointmentWidgetSize.height * 0.1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _numOfAppointments(Size numOfAppointmentsSize) {
    return Container(
      width: numOfAppointmentsSize.width,
      height: numOfAppointmentsSize.height,
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        '25 Appointments',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'Lato',
        ),
      ),
    );
  }

  _title(Size titleSize) {
    return Container(
      width: titleSize.width,
      height: titleSize.height,
      alignment: AlignmentDirectional.center,
      child: Text(
        'Appointments Overview',
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
        ),
      ),
    );
  }

  _appointmentWidget(
    ServiceProvidersAppointmentModel appointment,
    Size appointmentWidgetSize,
  ) {
    double sidePad = appointmentWidgetSize.width * 0.05;
    double topBottomPad = appointmentWidgetSize.height * 0.05;
    Size size = Size(appointmentWidgetSize.width - 2 * sidePad,
        appointmentWidgetSize.height - 2 * topBottomPad);
    Size providerNameSize = Size(size.width, size.height * 0.2);
    Size categorySize = Size(size.width, providerNameSize.height);
    Size dateSize = Size(size.width * 0.4, size.height * 0.15);
    Size timeSize = Size(size.width * 0.35, dateSize.height);
    Size ratingSize = Size(size.width, size.height * 0.3);
    Size actionsSize = Size(size.width, size.height * 0.3);
    return Container(
      width: appointmentWidgetSize.width,
      height: appointmentWidgetSize.height,
      padding: EdgeInsets.only(
        left: sidePad,
        right: sidePad,
        top: topBottomPad,
        bottom: topBottomPad,
      ),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(appointmentWidgetSize.width * 0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _providerData(appointment, providerNameSize, categorySize),
          _dateTimeWidget(
            dateSize,
            timeSize,
            appointment,
          ),
          appointment.isCompleted
              ? _ratingWidget(ratingSize)
              : _actionsWidget(actionsSize),
        ],
      ),
    );
  }

  _providerData(ServiceProvidersAppointmentModel appointment, Size providerSize,
      Size categorySize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        [appointment.providerName, providerSize, false],
        [appointment.category, categorySize, true]
      ]
          .map(
            (val) => _providerDataValue(
                val[0] as String, val[1] as Size, val[2] as bool),
          )
          .toList(),
    );
  }

  Widget _providerDataValue(String value, Size size, bool isCategoryValue) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Text(
        value,
        style: TextStyle(
          fontSize: isCategoryValue ? 14 : 15,
          fontWeight: isCategoryValue ? FontWeight.w400 : FontWeight.w600,
          fontFamily: 'Lato',
        ),
      ),
    );
  }

  _dateTimeWidget(
    Size dateSize,
    Size timeSize,
    ServiceProvidersAppointmentModel appointment,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        [appointment.date, FontAwesomeIcons.calendar, dateSize],
        [appointment.time, FontAwesomeIcons.clock, timeSize]
      ]
          .map(
            (val) => _dateTimeValueWidget(
              val[0] as String,
              val[1] as IconData,
              val[2] as Size,
            ),
          )
          .toList(),
    );
  }

  Widget _dateTimeValueWidget(
    String value,
    IconData iconData,
    Size dateTimeSize,
  ) {
    Size iconSize = Size(dateTimeSize.width * 0.2, dateTimeSize.height);
    return Row(
      children: [
        SizedBox(
          width: iconSize.width,
          height: iconSize.height,
          child: Icon(
            iconData,
            size: iconSize.height * 0.75,
          ),
        ),
        Container(
          width: dateTimeSize.width,
          height: dateTimeSize.height,
          alignment: AlignmentDirectional.center,
          color: transparent,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              fontFamily: 'Lato',
            ),
          ),
        ),
      ],
    );
  }

  _ratingWidget(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [true, true, true, false, false]
            .map(
              (val) => Icon(
                val ? Icons.star : Icons.star_border,
                color: val ? kAmber : k1Gray,
                size: size.height * 0.5,
              ),
            )
            .toList(),
      ),
    );
  }

  _actionsWidget(Size size) {
    Size buttonSize = Size(size.width * 0.45, size.height);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ['Cancel']
            .map(
              (val) => Material(
                color: transparent,
                child: InkWell(
                  onTap: () {},
                  splashColor: kHeaderColor,
                  child: Container(
                    width: buttonSize.width,
                    height: buttonSize.height,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      color: kHeaderColor,
                      borderRadius:
                          BorderRadius.circular(buttonSize.width * 0.2),
                      border: Border.all(
                        width: 2,
                        color: kBlack,
                      ),
                    ),
                    child: Text(
                      val,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
