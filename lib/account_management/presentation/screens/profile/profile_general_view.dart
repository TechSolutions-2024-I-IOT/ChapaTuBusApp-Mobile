import 'package:chapa_tu_bus_app/account_management/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileGeneralView extends StatefulWidget {
  static const name = 'Profile';
  static String getViewName() => name;
  const ProfileGeneralView({super.key});

  @override
  State<ProfileGeneralView> createState() => _ProfileGeneralViewState();
}

class _ProfileGeneralViewState extends State<ProfileGeneralView> {
  @override
  void initState() {
    super.initState();
    // Disparar evento para cargar el perfil del usuario
    context.read<ProfileBloc>().add(ProfileLoadRequested());
  }

  void _signOut() {
    // Disparar evento para cerrar sesión
    context.read<ProfileBloc>().add(ProfileSignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // Manejar estados que requieren acciones (como navegación)
        if (state is ProfileSignOutSuccess) {
          context.go('/start');
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        // Construir la UI en función del estado del ProfileBloc
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          final user = state.user;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL ?? ''),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Opciones del perfil (puedes adaptarlas según tus necesidades)
                  BuildProfileOption(
                    icon: Icons.settings,
                    text: 'Configuración',
                    isShowMore: true,
                    onTap: () async {
                      context.go('/home/3/settings');
                    },
                  ),
                  BuildProfileOption(
                    icon: Icons.credit_card,
                    text: 'Pagos',
                    isShowMore: true,
                    onTap: () {
                      context.go('/home/3/payments');
                    },
                  ),
                  BuildProfileOption(
                    icon: Icons.percent,
                    text: 'Mi suscripción',
                    isShowMore: true,
                    onTap: () {
                      context.go('/home/3/subscriptions');
                    },
                  ),
                  BuildProfileOption(
                    icon: Icons.favorite,
                    text: 'Mis favoritos',
                    isShowMore: true,
                    onTap: () {
                      context.go('/home/2');
                    },
                  ),
                  const BuildProfileOption(
                    icon: Icons.notifications,
                    text: 'Notificaciones',
                    isSwitch: true,
                  ),

                  BuildProfileOption(
                    icon: Icons.exit_to_app,
                    text: 'Cerrar sesión',
                    onTap: _signOut,
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class BuildProfileOption extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSwitch;
  final bool isShowMore;
  final VoidCallback? onTap;
  const BuildProfileOption(
      {super.key,
      required this.icon,
      required this.text,
      this.isSwitch = false,
      this.isShowMore = false,
      this.onTap});

  @override
  State<BuildProfileOption> createState() => _BuildProfileOptionState();
}

class _BuildProfileOptionState extends State<BuildProfileOption> {
  bool notificationsEnabled = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: SizedBox(
          height: 55,
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.grey),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              if (widget.isSwitch)
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                    activeColor: Colors.blue,
                    trackColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.blue[100]!;
                        }
                        return Colors.grey[300]!;
                      },
                    ),
                  ),
                )
              else if (widget.isShowMore)
                const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
