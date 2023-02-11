import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo/core/utils/filter_model.dart';

const List<FilterMenuItem> saleOrderActiveFilterItems = [
  FilterMenuItem(
    title: 'Activos',
    where: "('active','=',1)",
  ),
  FilterMenuItem(
    title: 'Inactivos',
    where: "('active','!=',1)",
  ),
  FilterMenuItem(
    title: 'Todos',
    icon: FluentIcons.list,
    where: "",
  ),
];

const saleOrderEstateFilterItemsInitialValue = 'Pedido de Venta';
const List<FilterMenuItem> saleOrderEstateFilterItems = [
  FilterMenuItem(
    title: 'Todos',
    where: "",
  ),
  FilterMenuItem(
    title: 'Borrador',
    where: "('state','=','draft')",
  ),
  FilterMenuItem(
    title: 'Enviado',
    where: "('state','=','draft')",
  ),
  FilterMenuItem(
    title: 'Pedido de Venta',
    icon: FluentIcons.list,
    where: "('state','=','sale')",
  ),
  FilterMenuItem(
    title: 'Bloqueado',
    where: "('state','=','done')",
  ),
  FilterMenuItem(
    title: 'A la espera de Aprobación',
    where: "('state','=','waiting_approval')",
  ),
  FilterMenuItem(
    title: 'Aprobado',
    icon: FluentIcons.list,
    where: "('state','=','approved')",
  ),
  FilterMenuItem(
    title: 'Hecho',
    icon: FluentIcons.list,
    where: "('state','=','posted')",
  ),
  FilterMenuItem(
    title: 'Rechazado',
    icon: FluentIcons.list,
    where: "('state','=','rejected')",
  ),
  FilterMenuItem(
    title: 'Cancelado',
    icon: FluentIcons.list,
    where: "('state','=','cancel')",
  ),
];

// var stateSaleOrderField = {
//   'draft': 'Borrador',
//   'sent': 'Enviado',
//   'sale': 'Pedido de Venta',
//   'done': 'Bloqueado',
//   'waiting_approval': 'A la espera de Aprobación',
//   'approved': 'Aprobado',
//   'posted': 'Hecho',
//   'rejected': 'Rechazado',
//   'cancel': 'Cancelado',
// };